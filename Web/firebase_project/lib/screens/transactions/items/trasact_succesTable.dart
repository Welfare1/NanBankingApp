import 'package:firebase_project/screens/Customer/customers.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:firebase_project/screens/transactions/transaction_Prototype.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListTransactionSucc extends StatelessWidget {
  ListTransactionSucc({
    super.key,
    required TransacSuccDataSource transacSuccDataSource,
  }) : _transacSuccDataSource = transacSuccDataSource;

  final TransacSuccDataSource _transacSuccDataSource;
  final DataGridController _dataGridController = DataGridController();

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
          headerColor: const Color.fromARGB(255, 240, 237, 239)),
      child: SfDataGrid(
          controller: _dataGridController,
          selectionMode: SelectionMode.single,
          // navigationMode: GridNavigationMode.cell,
          source: _transacSuccDataSource,
          // allowSorting: true,
          // allowEditing: true,
          allowFiltering: true,
          columnWidthMode: ColumnWidthMode.auto,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          columns: [
            GridColumn(
                columnName: 'ref',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Ref',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'numCliDeb',
                filterPopupMenuOptions: const FilterPopupMenuOptions(
                    filterMode: FilterMode.checkboxFilter),
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'N°Client débité',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'numCliCred',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'N°Client crédité',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'nomClientCred',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Nom client crédité',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'banque',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Banque',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'dateTrasanc',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Date transaction',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'dateEffect',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Date effective',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'gestionnaire',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Gestionnaire',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'montant',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Montant',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'typeOperat',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Type d'opération",
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'guichet',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Guichet',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'approved',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Approuvé',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
          ]),
    );
  }
}

class TransacSuccDataSource extends DataGridSource {
  TransacSuccDataSource(List<TransactionPrototype> transaction) {
    dataGridRows = transaction
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell(columnName: 'ref', value: dataGridRow.ref),
              DataGridCell(
                  columnName: 'numCliDeb', value: dataGridRow.numCliDeb),
              DataGridCell(
                  columnName: 'numCliCred', value: dataGridRow.numCliCred),
              DataGridCell(
                  columnName: 'nomClientCred',
                  value: dataGridRow.nomClientCred),
              DataGridCell(columnName: 'banque', value: dataGridRow.banque),
              DataGridCell(
                  columnName: 'dateTransac', value: dataGridRow.dateTransac),
              DataGridCell(
                  columnName: 'dateEffect', value: dataGridRow.dateEffect),
              DataGridCell(
                  columnName: 'gestionnaire', value: dataGridRow.gestionnaire),
              DataGridCell(columnName: 'montant', value: dataGridRow.montant),
              DataGridCell(
                  columnName: 'typeOperat', value: dataGridRow.typeOperat),
              DataGridCell(columnName: 'guichet', value: dataGridRow.guichet),
              DataGridCell(columnName: 'approved', value: dataGridRow.approved),
            ]))
        .toList();
  }
  late List<DataGridRow> dataGridRows;
  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: (dataGridCell.columnName == 'id' ||
                dataGridCell.columnName == 'dateCreat')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Text(
          dataGridCell.value.toString(),
          style: GoogleFonts.quicksand(fontSize: 12),
        ),
      );
    }).toList());
  }
}

class ReadPageTranSucc extends StatefulWidget {
  ReadPageTranSucc({super.key});

  @override
  State<ReadPageTranSucc> createState() => _ReadPageTranSuccState();
}

class _ReadPageTranSuccState extends State<ReadPageTranSucc> {
  late TransacSuccDataSource _transacSuccDataSource;

  //   @override
  // void initState() {
  // _customerDataSource = CustomerDataSource(_customers);
  //   super.initState();

  // }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder<List<TransactionPrototype>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something is wron ${snapshot.error}");
          } else if (snapshot.hasData) {
            final transactions = snapshot.data!;
            _transacSuccDataSource = TransacSuccDataSource(transactions);
            return ListTransactionSucc(
                transacSuccDataSource: _transacSuccDataSource);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<TransactionPrototype>> readUsers() => FirebaseFirestore.instance
      .collection("Transactions")
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => TransactionPrototype.fromJson(doc.data()))
          .toList()
          .reversed
          .toList());

  Widget builderUser(TransactionPrototype transaction) => ListTile(
        leading: Container(
          color: Colors.lightBlue,
          child: Text(transaction.gestionnaire),
        ),
        title: Text(transaction.gestionnaire),
        subtitle: Text("customer.dateNaissance"),
      );
}
