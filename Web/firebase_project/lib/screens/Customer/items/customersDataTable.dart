import 'package:firebase_project/screens/Customer/customers.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ListCustomer extends StatelessWidget {
  ListCustomer({
    super.key,
    required CustomerDataSource customerDataSource,
  }) : _customerDataSource = customerDataSource;

  final CustomerDataSource _customerDataSource;
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
          source: _customerDataSource,
          // allowSorting: true,
          // allowEditing: true,
          allowFiltering: true,
          columnWidthMode: ColumnWidthMode.auto,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          columns: [
            GridColumn(
                columnName: 'id',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Id',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'nom',
                filterPopupMenuOptions: const FilterPopupMenuOptions(
                    filterMode: FilterMode.checkboxFilter),
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Nom',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'prenoms',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Prénoms',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'dateNaissance',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Date de naissance',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'profession',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Profession',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'numPce',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('N°Pièce Id',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'numTel',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('N°téléphone',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'solde',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Solde',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'mail',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Adresse mail',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'sexe',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Sexe',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'typeCpt',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Type de compte',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'gestionnaire',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Gestionnaire',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'nombre de transaction',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Nb transactions',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
            GridColumn(
                columnName: 'dateCreat',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Date de creation',
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleSmall)),
                )),
          ]),
    );
  }
}

class CustomerDataSource extends DataGridSource {
  CustomerDataSource(List<Customer> customer) {
    dataGridRows = customer
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell(columnName: 'id', value: dataGridRow.id),
              DataGridCell(columnName: 'nom', value: dataGridRow.nom),
              DataGridCell(columnName: 'prenoms', value: dataGridRow.prenoms),
              DataGridCell(
                  columnName: 'dateNaissance',
                  value: dataGridRow.dateNaissance),
              DataGridCell(
                  columnName: 'profession', value: dataGridRow.profession),
              DataGridCell(columnName: 'numPce', value: dataGridRow.numPce),
              DataGridCell(columnName: 'numTel', value: dataGridRow.numTel),
              DataGridCell(columnName: 'solde', value: dataGridRow.solde),
              DataGridCell(columnName: 'mail', value: dataGridRow.mail),
              DataGridCell(columnName: 'sexe', value: dataGridRow.sexe),
              DataGridCell(columnName: 'typeCpt', value: dataGridRow.typeCpt),
              DataGridCell(
                  columnName: 'gestionnaire', value: dataGridRow.gestionnaire),
              DataGridCell(
                  columnName: 'nbTransac', value: dataGridRow.nbTransac),
              DataGridCell(
                  columnName: 'dateCreat', value: dataGridRow.dateCreat),
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
        child: Text(dataGridCell.value.toString(),
            style: GoogleFonts.poppins(fontSize: 12)),
      );
    }).toList());
  }
}
