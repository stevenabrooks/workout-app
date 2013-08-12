function doGet() {
  var data = Charts.newDataTable()
      .addColumn(Charts.ColumnType.STRING, "Name")
      .addColumn(Charts.ColumnType.STRING, "Gender")
      .addColumn(Charts.ColumnType.NUMBER, "Exercise")
      .addColumn(Charts.ColumnType.NUMBER, "Donuts eaten")
      .addRow(["Steven", "Dips", 12000, 5])
      .addRow(["Michael", "Bench Press", 12, 5])
      .addRow(["Elisa", "Pullups", 20, 7])
      .addRow(["Robert", "Dips", 7, 3])
      .addRow(["John", "Toe to Bar", 54, 2])
      .addRow(["Jessica", "Squats", 22, 6])
      .addRow(["Aaron", "Deadlift", 3, 1])
      .addRow(["Margareth", "Dips", 42, 8])
      .addRow(["Miranda", "Squats", 33, 6])
      .build();

  var exerciseFilter = Charts.newNumberRangeFilter()
      .setFilterColumnLabel("Exercise")
      .build();

  var genderFilter = Charts.newCategoryFilter()
      .setFilterColumnLabel("Gender")
      .build();

  var pieChart = Charts.newPieChart()
      .setDataViewDefinition(Charts.newDataViewDefinition()
                            .setColumns([0,3]))
      .build();

  var tableChart = Charts.newTableChart()
      .build();

  var dashboard = Charts.newDashboardPanel()
      .setDataTable(data)
      .bind([exerciseFilter, genderFilter], [pieChart, tableChart])
      .build();

  var uiApp = UiApp.createApplication();

  dashboard.add(uiApp.createVerticalPanel()
                .add(uiApp.createHorizontalPanel()
                    .add(exerciseFilter).add(genderFilter)
                    .setSpacing(70))
                .add(uiApp.createHorizontalPanel()
                    .add(pieChart).add(tableChart)
                    .setSpacing(10)));

  uiApp.add(dashboard);
  return uiApp;
}