import { pearson, spearman, skewness, excessKurtosis, quantiles } from './stats.js';

google.charts.load('current', {packages: ['corechart', 'table']});
google.charts.setOnLoadCallback(drawChart);

async function drawChart() {
  // Exempeldata för test
  const x = [1,2,3,4,5];
  const y = [1,1.5,2.8,3.9,5.1];

  console.log("Pearson:", pearson(x,y));
  console.log("Spearman:", spearman(x,y));

  const data = new google.visualization.DataTable();
  data.addColumn('number', 'X');
  data.addColumn('number', 'Y');
  x.forEach((xi, i) => data.addRow([xi, y[i]]));

  const chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));
  chart.draw(data, {title: "Exempel: X vs Y"});
}
