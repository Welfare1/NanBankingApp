import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:firebase_project/screens/transactions/transaction_Prototype.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListTransacSumComing extends StatelessWidget {
  ListTransacSumComing({
    super.key,
    required TransacSumComingDataSource transacSumComingDataSource,
  }) : _transacSumComingDataSource = transacSumComingDataSource;

  final TransacSumComingDataSource _transacSumComingDataSource;
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
          source: _transacSumComingDataSource,
          // allowSorting: true,
          // allowEditing: true,
          // allowFiltering: true,
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          // gridLinesVisibility: GridLinesVisibility.both,
          // headerGridLinesVisibility: GridLinesVisibility.both,
          columns: [
            GridColumn(
                columnName: 'reference',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Reférence',
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyMedium),
                  ),
                )),
            GridColumn(
                columnName: 'numCliDeb',
                filterPopupMenuOptions: const FilterPopupMenuOptions(
                    filterMode: FilterMode.checkboxFilter),
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'N°Client débité',
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyMedium),
                  ),
                )),
            GridColumn(
                columnName: 'numCliCred',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'N°Client crédité',
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyMedium),
                  ),
                )),
            GridColumn(
                columnName: 'dateEffect',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Date effective',
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyMedium),
                  ),
                )),
            GridColumn(
                columnName: 'montant',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Montant',
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyMedium),
                  ),
                )),
          ]),
    );
  }
}

class TransacSumComingDataSource extends DataGridSource {
  TransacSumComingDataSource(List<TransactionPrototype> transaction) {
    dataGridRows = transaction
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell(columnName: 'reference', value: dataGridRow.ref),
              DataGridCell(
                  columnName: 'numCliDeb', value: dataGridRow.numCliDeb),
              DataGridCell(
                  columnName: 'numCliCred', value: dataGridRow.numCliCred),
              DataGridCell(
                  columnName: 'dateEffect', value: dataGridRow.dateEffect),
              DataGridCell(columnName: 'montant', value: dataGridRow.montant),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: (dataGridCell.columnName == 'reference' ||
                dataGridCell.columnName == 'dateCreat')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Text(
          dataGridCell.value.toString(),
          style: GoogleFonts.quicksand(fontSize: 10),
        ),
      );
    }).toList());
  }
}

class ReadPageTranSumComing extends StatefulWidget {
  ReadPageTranSumComing({super.key});

  @override
  State<ReadPageTranSumComing> createState() => _ReadPageTranSumComingState();
}

class _ReadPageTranSumComingState extends State<ReadPageTranSumComing> {
  late TransacSumComingDataSource _transacSumComingDataSource;

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
            _transacSumComingDataSource =
                TransacSumComingDataSource(transactions);
            return ListTransacSumComing(
                transacSumComingDataSource: _transacSumComingDataSource);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<TransactionPrototype>> readUsers() => FirebaseFirestore.instance
      .collection("Transactions_coming")
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
