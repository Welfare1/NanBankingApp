import 'package:firebase_project/screens/Customer/customers.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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
      data:
          SfDataGridThemeData(headerColor: Color.fromARGB(255, 240, 237, 239)),
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
                  child: const Text(
                    'Id',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'nom',
                filterPopupMenuOptions: const FilterPopupMenuOptions(
                    filterMode: FilterMode.checkboxFilter),
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Nom',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'prenoms',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Prénoms',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'dateNaissance',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Date de naissance',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'profession',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Profession',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'numPce',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'N°Pièce Id',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'numTel',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'N°téléphone',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'solde',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Solde',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'mail',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Adresse mail',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'sexe',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Sexe',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'typeCpt',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Type de compte',
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
                columnName: 'nombre de transaction',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Nb transactions',
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                columnName: 'dateCreat',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Date de creation',
                    overflow: TextOverflow.ellipsis,
                  ),
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
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
