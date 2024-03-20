import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:wvw/tabel_wvw.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("WvW Interpolation and Extrapolation"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'BONITA'),
              Tab(text: 'TEGAKAN'),
              Tab(text: 'LBDS'),
              Tab(text: 'VOLUME'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            JsonTable(
              TabelWvW.bonita,
            ),
            JsonTable(
              TabelWvW.tegakan,
            ),
            JsonTable(
              TabelWvW.lbds,
            ),
            JsonTable(
              TabelWvW.volume,
            ),
          ],
        ),
      ),
    );
  }
}
