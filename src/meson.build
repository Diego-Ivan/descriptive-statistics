descriptive_statistics_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
  'enums.vala',

  # Widgets
  'Widgets/DataRow.vala',
  'Widgets/VisualizationGrid.vala',
  'Widgets/ResultsList.vala',
  'Widgets/ResultPage.vala',

  # Services
  'Services/ColumnFactory.vala',

  # Models
  'Models/DataCalculator.vala',
  'Models/Column.vala',
  'Models/Results.vala',
  'Models/Row.vala',

  # Operators
  'Models/Operators/AbstractOperator.vala',
  'Models/Operators/Kurtosis.vala',
  'Models/Operators/Maximum.vala',
  'Models/Operators/Mean.vala',
  'Models/Operators/Median.vala',
  'Models/Operators/Minimum.vala',
  'Models/Operators/Mode.vala',
  'Models/Operators/SampleVariance.vala',
  'Models/Operators/Skewness.vala',
  'Models/Operators/StandardDeviation.vala',
  'Models/Operators/StandardError.vala',
  'Models/Operators/Sum.vala',
]

cc = meson.get_compiler('c')
math = cc.find_library('m', required: false)

descriptive_statistics_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1'),
  dependency('glib-2.0'),
  dependency('gee-0.8'),
  math,
]

descriptive_statistics_sources += gnome.compile_resources('descriptive-statistics-resources',
  'descriptive-statistics.gresource.xml',
  c_name: 'descriptive_statistics'
)

executable('descriptive-statistics', descriptive_statistics_sources,
  dependencies: descriptive_statistics_deps,
       install: true,
)
