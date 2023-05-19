import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_project/constants.dart';
import 'package:firebase_project/screens/items/headBox.dart';
import 'package:badges/badges.dart' as badges;
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:firebase_project/screens/Customer/items/dropButton.dart';
import 'package:firebase_project/constants.dart';
import 'package:firebase_project/screens/Customer/items/radioHF.dart';
import 'customers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/screens/Customer/items/custForm.dart';
import 'package:firebase_project/screens/Customer/items/customersDataTable.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> with TickerProviderStateMixin {
  TabController? tabController1;
  late List<Customer> _customers; // For the eleve's class
  late CustomerDataSource _customerDataSource;
  int index = 0; //In order to use it further for dynamic displaying

  // Customer register

  void _tabListener() {
    setState(() {
      index = tabController1!.index; //For adjustement
    });
  }

  @override
  void initState() {
    tabController1 = TabController(length: 3, vsync: this);
    tabController1!.addListener(_tabListener);
    _customers = Customer.getCustomerData(); //Giving the
    _customerDataSource = CustomerDataSource(_customers);
    super.initState();
    // Intl.defaultLocale = 'fr_FR';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController1!.removeListener(_tabListener);
    tabController1!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        HeadMain(mainTitle: "Comptes clients"),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabarNavigationClients(tabController: tabController1),
              Text(
                "Nombre de clients : 140 ",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
        ),
        Flexible(
          child: TabBarView(controller: tabController1, children: [
            Container(
                // color: Colors.teal,
                child: ReadPage()),
            Container(
              color: Colors.white,
              child: const CustForm(),
            ),
            Container(
              color: Colors.red,
              // child: ListNotes(eleveDataSource: _eleveDataSource),
            ),
          ]),
        ),
      ],
    ));
  }
}

class TabarNavigationClients extends StatelessWidget {
  //TabBarNavigation of the Notes Attributions
  const TabarNavigationClients({
    super.key,
    required this.tabController,
  });

  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: tabController,
        isScrollable: true,
        labelPadding: const EdgeInsets.all(14.0),
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.black,
        automaticIndicatorColorAdjustment: true,
        labelColor: Colors.black,
        // indicator: BoxDecoration(
        //   color: Colors.black,
        //   borderRadius: BorderRadius.circular(15),
        // ),
        tabs: const [
          badges.Badge(
            badgeContent: Text('3'),
            child: Text("Comptes clients "),
          ),
          badges.Badge(
            // badgeContent: Text('3'),
            child: Text("Ajouter un compte "),
          ),
          badges.Badge(
            // badgeContent: Text('3'),
            child: Text("Suspendre un compte "),
          ),
        ]);
  }
}

class ReadPage extends StatefulWidget {
  ReadPage({super.key});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  late CustomerDataSource _customerDataSource;

  //   @override
  // void initState() {
  // _customerDataSource = CustomerDataSource(_customers);
  //   super.initState();

  // }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder<List<Customer>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something is wron ${snapshot.error}");
          } else if (snapshot.hasData) {
            final customers = snapshot.data!;
            _customerDataSource = CustomerDataSource(customers);
            return ListCustomer(customerDataSource: _customerDataSource);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<Customer>> readUsers() => FirebaseFirestore.instance
      .collection("Customers")
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => Customer.fromJson(doc.data())).toList());

  Widget builderUser(Customer customer) => ListTile(
        leading: Container(
          color: Colors.lightBlue,
          child: Text(customer.prenoms),
        ),
        title: Text(customer.nom),
        subtitle: Text("customer.dateNaissance"),
      );
}
