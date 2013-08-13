//load google graph api

google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);
function drawChart() {
  var data = google.visualization.arrayToDataTable(graph);

  data.setColumnProperty(2, 'role', 'tooltip');
  data.setColumnProperty(4, 'role', 'tooltip');
  data.setColumnProperty(6, 'role', 'tooltip');
  data.setColumnProperty(8, 'role', 'tooltip');
  data.setColumnProperty(10, 'role', 'tooltip');
  



  var options = {
    title: 'Your Workout',
    hAxis: {title: 'Exercises'},
    vAxis: {title: 'Total Weight (pounds)'}
  };

  var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
  chart.draw(data, options);
}

// [["exercise", "set 1", "set 2", "set 3", "set 4", "set 5"], 
// ["Hip Abductor Machine", 600, 700, 800, 900, 1000], 
// ["Squats", 1350, 1850, 2250, 0, 0], 
// ["DB RDLs", 400, 480, 560, 0, 0], 
// ["Standing Calf Raises", 360, 720, 1080, 0, 0]] 