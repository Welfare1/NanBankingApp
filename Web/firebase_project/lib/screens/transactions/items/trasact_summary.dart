import 'package:firebase_project/screens/Customer/customers.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:firebase_project/screens/transactions/transaction_Prototype.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListTransactionSum extends StatelessWidget {
  ListTransactionSum({
    super.key,
    required TransacSumDataSource transacSumDataSource,
  }) : _transacSumDataSource = transacSumDataSource;

  final TransacSumDataSource _transacSumDataSource;
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
          source: _transacSumDataSource,
          // allowSorting: true,
          // allowEditing: true,
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          isScrollbarAlwaysShown: true,
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
                    // overflow: TextOverflow.ellipsis,
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
                columnName: 'banque',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Banque',
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyMedium),
                  ),
                )),
            GridColumn(
                columnName: 'dateTrasanc',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Date transaction',
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
            GridColumn(
                columnName: 'typeOperat',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Type d'opération",
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyMedium),
                  ),
                )),
            GridColumn(
                columnName: 'approved',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Approuvé',
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyMedium),
                  ),
                )),
          ]),
    );
  }
}

class TransacSumDataSource extends DataGridSource {
  TransacSumDataSource(List<TransactionPrototype> transaction) {
    dataGridRows = transaction
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell(columnName: 'ref', value: dataGridRow.ref),
              DataGridCell(
                  columnName: 'numCliDeb', value: dataGridRow.numCliDeb),
              DataGridCell(
                  columnName: 'numCliCred', value: dataGridRow.numCliCred),
              DataGridCell(columnName: 'banque', value: dataGridRow.banque),
              DataGridCell(
                  columnName: 'dateTransac', value: dataGridRow.dateTransac),
              DataGridCell(columnName: 'montant', value: dataGridRow.montant),
              DataGridCell(
                  columnName: 'typeOperat', value: dataGridRow.typeOperat),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: (dataGridCell.columnName == 'id' ||
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

class ReadPageTranSum extends StatefulWidget {
  ReadPageTranSum({super.key});

  @override
  State<ReadPageTranSum> createState() => _ReadPageTranSumState();
}

class _ReadPageTranSumState extends State<ReadPageTranSum> {
  late TransacSumDataSource _TransacSumDataSource;

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
            _TransacSumDataSource = TransacSumDataSource(transactions);
            return ListTransactionSum(
                transacSumDataSource: _TransacSumDataSource);
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
