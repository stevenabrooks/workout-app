//load google graph api

google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);
function drawChart() {
  var data = google.visualization.arrayToDataTable(graph);

  var options = {
    title: 'Your Workout',
    hAxis: {title: 'Exercises'},
    vAxis: {title: 'Total Weight (pounds)'}
  };

  var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
  chart.draw(data, options);
}