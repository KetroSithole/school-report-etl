// ---------- Bronze: parse raw CSV ----------
const SUBJECTS = [
  ["mathematics_mark", "Mathematics"],
  ["physical_science_mark", "Physical Science"],
  ["life_sciences_mark", "Life Sciences"],
  ["english_home_language_mark", "English HL"],
  ["life_orientation_mark", "Life Orientation"],
  ["information_technology_mark", "Information Tech"],
  ["agricultural_science_mark", "Agricultural Sci"],
];
const FAIL_THRESHOLD = 40;

function parseCsv(text) {
  const [header, ...lines] = text.trim().split("\n");
  const cols = header.split(",");
  return lines.map((line) => {
    const vals = line.split(",");
    const row = {};
    cols.forEach((c, i) => {
      row[c] = /_mark$/.test(c) ? Number(vals[i]) : vals[i];
    });
    return row;
  });
}

const bronze = parseCsv(RAW_CSV);

// ---------- Silver: clean + enrich ----------
const silver = bronze.map((r) => {
  const grade_band = r.grade.replace(/[AB]$/, "");
  const subjects_failed = SUBJECTS.filter(([k]) => r[k] < FAIL_THRESHOLD).length;
  const overall_result =
    r.average_mark >= FAIL_THRESHOLD && subjects_failed <= 2 ? "PASS" : "FAIL";
  return { ...r, grade_band, subjects_failed, overall_result };
});

// ---------- Gold: aggregates ----------
const BANDS = ["10", "11", "12"];

const gradeSummary = BANDS.map((band) => {
  const rows = silver.filter((r) => r.grade_band === band);
  const pass = rows.filter((r) => r.overall_result === "PASS").length;
  return {
    grade_band: band,
    student_count: rows.length,
    avg_of_averages: rows.reduce((s, r) => s + r.average_mark, 0) / rows.length,
    pass_count: pass,
    fail_count: rows.length - pass,
    pass_rate_pct: (pass / rows.length) * 100,
  };
});

const subjectPerformance = BANDS.flatMap((band) => {
  const rows = silver.filter((r) => r.grade_band === band);
  return SUBJECTS.map(([key, label]) => {
    const marks = rows.map((r) => r[key]);
    return {
      grade_band: band,
      subject: label,
      avg_mark: marks.reduce((s, m) => s + m, 0) / marks.length,
      min_mark: Math.min(...marks),
      max_mark: Math.max(...marks),
      fail_count: marks.filter((m) => m < FAIL_THRESHOLD).length,
    };
  });
});

// ---------- KPI cards ----------
const totalPass = silver.filter((r) => r.overall_result === "PASS").length;
const overallAvg = silver.reduce((s, r) => s + r.average_mark, 0) / silver.length;
const topStudent = [...silver].sort((a, b) => b.average_mark - a.average_mark)[0];

document.getElementById("kpis").innerHTML = `
  <div class="kpi"><div class="label">Students</div><div class="value">${silver.length}</div></div>
  <div class="kpi"><div class="label">Overall average</div><div class="value">${overallAvg.toFixed(1)}%</div></div>
  <div class="kpi"><div class="label">Passing</div><div class="value pass">${totalPass}</div></div>
  <div class="kpi"><div class="label">Failing</div><div class="value fail">${silver.length - totalPass}</div></div>
  <div class="kpi"><div class="label">Top student</div><div class="value" style="font-size:1.15rem">${topStudent.student_name}<br><small style="color:var(--muted)">${topStudent.average_mark.toFixed(1)}% · ${topStudent.grade}</small></div></div>
`;

// ---------- Grade summary cards ----------
document.getElementById("grade-summary").innerHTML = gradeSummary
  .map(
    (g) => `
  <div class="band-card">
    <h3>Grade ${g.grade_band}</h3>
    <dl>
      <dt>Students</dt><dd>${g.student_count}</dd>
      <dt>Avg of averages</dt><dd>${g.avg_of_averages.toFixed(1)}%</dd>
      <dt>Pass / Fail</dt><dd><span style="color:var(--pass)">${g.pass_count}</span> / <span style="color:var(--fail)">${g.fail_count}</span></dd>
      <dt>Pass rate</dt><dd>${g.pass_rate_pct.toFixed(1)}%</dd>
    </dl>
    <div class="meter"><span style="width:${g.pass_rate_pct}%"></span></div>
  </div>`
  )
  .join("");

// ---------- Charts ----------
Chart.defaults.color = "#93a0b4";
Chart.defaults.borderColor = "#2a3242";

const bandColors = { 10: "#5eadf2", 11: "#e8b93e", 12: "#c084fc" };

new Chart(document.getElementById("subjectChart"), {
  type: "bar",
  data: {
    labels: SUBJECTS.map(([, label]) => label),
    datasets: BANDS.map((band) => ({
      label: `Grade ${band}`,
      data: SUBJECTS.map(
        ([, label]) =>
          subjectPerformance.find((s) => s.grade_band === band && s.subject === label).avg_mark
      ),
      backgroundColor: bandColors[band],
      borderRadius: 4,
    })),
  },
  options: {
    responsive: true,
    scales: { y: { beginAtZero: true, max: 100, title: { display: true, text: "Average mark %" } } },
  },
});

new Chart(document.getElementById("passChart"), {
  type: "bar",
  data: {
    labels: BANDS.map((b) => `Grade ${b}`),
    datasets: [
      {
        label: "Pass",
        data: gradeSummary.map((g) => g.pass_count),
        backgroundColor: "#4cc38a",
        borderRadius: 4,
      },
      {
        label: "Fail",
        data: gradeSummary.map((g) => g.fail_count),
        backgroundColor: "#e5534b",
        borderRadius: 4,
      },
    ],
  },
  options: {
    responsive: true,
    scales: {
      x: { stacked: true },
      y: { stacked: true, beginAtZero: true, title: { display: true, text: "Students" } },
    },
  },
});

// ---------- Student explorer ----------
const tbody = document.querySelector("#studentTable tbody");
const searchInput = document.getElementById("search");
const bandFilter = document.getElementById("bandFilter");
const resultFilter = document.getElementById("resultFilter");
const rowCount = document.getElementById("rowCount");

let sortKey = "student_id";
let sortAsc = true;

function renderTable() {
  const q = searchInput.value.trim().toLowerCase();
  const band = bandFilter.value;
  const result = resultFilter.value;

  let rows = silver.filter(
    (r) =>
      (!q || r.student_name.toLowerCase().includes(q) || r.student_id.toLowerCase().includes(q)) &&
      (!band || r.grade_band === band) &&
      (!result || r.overall_result === result)
  );

  rows.sort((a, b) => {
    const av = a[sortKey], bv = b[sortKey];
    const cmp = typeof av === "number" ? av - bv : String(av).localeCompare(String(bv));
    return sortAsc ? cmp : -cmp;
  });

  tbody.innerHTML = rows
    .map((r) => {
      const markCells = SUBJECTS.map(
        ([k]) => `<td class="num ${r[k] < FAIL_THRESHOLD ? "mark-fail" : ""}">${r[k]}</td>`
      ).join("");
      return `<tr>
        <td>${r.student_id}</td>
        <td>${r.student_name}</td>
        <td>${r.grade}</td>
        <td>${r.grade_band}</td>
        ${markCells}
        <td class="num">${r.average_mark.toFixed(1)}</td>
        <td class="num">${r.subjects_failed}</td>
        <td><span class="badge ${r.overall_result.toLowerCase()}">${r.overall_result}</span></td>
      </tr>`;
    })
    .join("");

  rowCount.textContent = `${rows.length} of ${silver.length} students shown`;
}

document.querySelectorAll("#studentTable th").forEach((th) => {
  th.addEventListener("click", () => {
    const key = th.dataset.key;
    if (sortKey === key) sortAsc = !sortAsc;
    else { sortKey = key; sortAsc = true; }
    renderTable();
  });
});

[searchInput, bandFilter, resultFilter].forEach((el) =>
  el.addEventListener("input", renderTable)
);

renderTable();
