import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_project/screens/transactions/items/trasact_succesTable.dart';
import 'package:firebase_project/screens/transactions/items/trasact_comingTable.dart';
import 'package:firebase_project/screens/transactions/transaction_Prototype.dart';
import 'package:firebase_project/screens/items/headBox.dart';
import 'package:badges/badges.dart' as badges;
import 'package:firebase_project/screens/transactions/items/make_transaction.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with TickerProviderStateMixin {
  TabController? tabController1;
  late List<TransactionPrototype> _transaction; // For the eleve's class
  late TransacSuccDataSource _transacSuccDataSource;

  int index = 0; //In order to use it further for dynamic displaying

  void _tabListener() {
    setState(() {
      index = tabController1!.index; //For adjustement
    });
  }

  @override
  void initState() {
    tabController1 = TabController(length: 3, vsync: this);
    tabController1!.addListener(_tabListener);
    _transaction = TransactionPrototype.getTrasancData(); //Giving the
    _transacSuccDataSource = TransacSuccDataSource(_transaction);
    super.initState();
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
        HeadMain(mainTitle: "Transactions"),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabarNavigation(tabController: tabController1),
              Text(
                "",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
        Flexible(
          child: TabBarView(controller: tabController1, children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                child: ReadPageTranSucc()),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                child: ReadPageTranComing()),
            Container(
              color: Colors.white,
              child: const TransactionForm(),
            ),
          ]),
        ),
      ],
    ));
  }
}

class TabarNavigation extends StatelessWidget {
  //TabBarNavigation of the Notes Attributions
  const TabarNavigation({
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
            // badgeContent: Text('3'),
            child: Text(
              "Transactions actuelles ",
            ),
          ),
          badges.Badge(
            // badgeContent: Text('3'),
            child: Text("Transactions à venir "),
          ),
          badges.Badge(
            // badgeContent: Text('3'),
            child: Text("Effectuer une transaction "),
          ),
        ]);
  }
}
