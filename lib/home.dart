import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:wvw/tabel_wvw.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PlutoColumn> bonitaColumn = [];
  List<PlutoRow> bonitaRows = [];

  List<PlutoColumn> lbdsColumn = [];
  List<PlutoRow> lbdsRows = [];

  List<PlutoColumn> tegakanColumn = [];
  List<PlutoRow> tegakanRows = [];

  List<PlutoColumn> volumeColumn = [];
  List<PlutoRow> volumeRows = [];

  @override
  initState() {
    super.initState();

    bonitaColumn.addAll(_columnbyDB(TabelWvW.bonita));
    bonitaRows.addAll(_cellbyDB(TabelWvW.bonita));

    lbdsColumn.addAll(_columnbyDB(TabelWvW.lbds));
    lbdsRows.addAll(_cellbyDB(TabelWvW.lbds));

    tegakanColumn.addAll(_columnbyDB(TabelWvW.tegakan));
    tegakanRows.addAll(_cellbyDB(TabelWvW.tegakan));

    volumeColumn.addAll(_columnbyDB(TabelWvW.volume));
    volumeRows.addAll(_cellbyDB(TabelWvW.volume));
  }

  List<PlutoColumn> _columnbyDB(List<Map<String, String>> db) {
    return db[0].entries.map(
      (e) {
        return PlutoColumn(
          title: e.key,
          field: e.key,
          type: PlutoColumnType.text(),
          textAlign: PlutoColumnTextAlign.center,
          width: 120,
        );
      },
    ).toList();
  }

  List<PlutoRow> _cellbyDB(List<Map<String, String>> db) {
    var plutoRow = <PlutoRow>[];
    for (var i = 0; i < db.length; i++) {
      var cells = <String, PlutoCell>{};
      db[i].forEach(
        (key, value) {
          cells[key] = PlutoCell(value: value);
        },
      );
      plutoRow.add(PlutoRow(cells: cells));
    }
    return plutoRow;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("WvW Interpolation and Extrapolation"),
          bottom: const TabBar(tabs: [
            Tab(
              text: "Bonita",
            ),
            Tab(
              text: "LBDS",
            ),
            Tab(
              text: "Tegakan",
            ),
            Tab(
              text: "Volume",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            PlutoGridView(bonitaColumn: bonitaColumn, bonitaRows: bonitaRows),
            PlutoGridView(bonitaColumn: lbdsColumn, bonitaRows: lbdsRows),
            PlutoGridView(bonitaColumn: tegakanColumn, bonitaRows: tegakanRows),
            PlutoGridView(bonitaColumn: volumeColumn, bonitaRows: volumeRows),
          ],
        ),
      ),
    );
  }
}

class PlutoGridView extends StatelessWidget {
  const PlutoGridView({
    super.key,
    required this.bonitaColumn,
    required this.bonitaRows,
  });

  final List<PlutoColumn> bonitaColumn;
  final List<PlutoRow> bonitaRows;

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      mode: PlutoGridMode.select,
      onSelected: null,
      columns: bonitaColumn,
      rows: bonitaRows,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        event.stateManager.setShowColumnFilter(true);
      },
      configuration: PlutoGridConfiguration(
        columnFilter: PlutoGridColumnFilterConfig(
          filters: [
            ...FilterHelper.defaultFilters,
            const ClassYouImplemented(),
          ],
          resolveDefaultColumnFilter: (column, resolver) {
            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
          },
        ),
      ),
    );
  }
}

class ClassYouImplemented implements PlutoFilterType {
  @override
  String get title => 'Filter';

  @override
  get compare => ({
        required String? base,
        required String? search,
        required PlutoColumn? column,
      }) {
        var keys = search!.split(',').map((e) => e.toUpperCase()).toList();

        return keys.contains(base!.toUpperCase());
      };

  const ClassYouImplemented();
}
