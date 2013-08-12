function doGet() {
  var data = Charts.newDataTable()
      .addColumn(Charts.ColumnType.NUMBER, "Date")
      .addColumn(Charts.ColumnType.DATE, "RealDate")
      .addColumn(Charts.ColumnType.STRING, "Exercise")
      .addColumn(Charts.ColumnType.NUMBER, "Age")
      .addColumn(Charts.ColumnType.NUMBER, "Donuts eaten")
      .addRow([20130101, new Date(2013,01,01), "Dips", 12000, 5])
      .addRow([20130102, new Date(2013,01,02),"Bench Press", 12, 5])
      .addRow([20130103, new Date(2013,01,03),"Pullups", 20, 7])
      .addRow([20130104, new Date(2013,01,04),"Dips", 7, 3])
      .addRow([20130105, new Date(2013,01,05),"Squats", 54, 2])
      .addRow([20130106, new Date(2013,01,06),"Squats", 22, 6])
      .addRow([20130107, new Date(2013,01,07),"Deadlift", 3, 1])
      .addRow([20130108, new Date(2013,01,08),"Dips", 42, 8])
      .addRow([20130109, new Date(2013,01,09),"Bench Press", 33, 6])
      .build();

  var dateFilter = Charts.newNumberRangeFilter()
      .setFilterColumnLabel("Date")
      .build(); 

  var exerciseFilter = Charts.newCategoryFilter()
      .setFilterColumnLabel("Exercise")
      .build();

  var columnChart = Charts.newColumnChart()
      .setDataViewDefinition(Charts.newDataViewDefinition()
                            .setColumns([1,4]))
      .build();

  var tableChart = Charts.newTableChart()
      .build();

  var dashboard = Charts.newDashboardPanel()
      .setDataTable(data)
      .bind([dateFilter, exerciseFilter], [columnChart, tableChart])
      .build();

  var uiApp = UiApp.createApplication();

  dashboard.add(uiApp.createVerticalPanel()
                .add(uiApp.createHorizontalPanel()
                    .add(dateFilter).add(exerciseFilter)
                    .setSpacing(70))
                .add(uiApp.createHorizontalPanel()
                    .add(columnChart).add(tableChart)
                    .setSpacing(10)));

  uiApp.add(dashboard);
  return uiApp;
}