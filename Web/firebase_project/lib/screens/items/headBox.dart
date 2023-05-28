import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

class HeadMain extends StatelessWidget {
  String mainTitle;
  HeadMain({super.key, required this.mainTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            mainTitle,
            style: GoogleFonts.poppins(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset("images/ci.png"),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset("images/gambie.jpg"),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset("images/benin.png"),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset("images/burkina.png"),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset("images/mali.jpg"),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset("images/nigeria.jpg"),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset("images/togo.png"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey)),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.help),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BankingApp()));
                      },
                    )),
              ),
              const SizedBox(width: 3),
              Text(
                "Welfare",
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BankingApp extends StatefulWidget {
  @override
  _BankingAppState createState() => _BankingAppState();
}

class _BankingAppState extends State<BankingApp> {
  String displayText = '';

  void addToDisplay(String functionality) {
    setState(() {
      displayText = functionality;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de comptes bancaires',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gestion de comptes bancaires'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                displayText,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => addToDisplay('Ajouter un compte'),
                    child: Text('Ajouter un compte'),
                  ),
                  ElevatedButton(
                    onPressed: () => addToDisplay('Rechercher un compte'),
                    child: Text('Rechercher un compte'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => addToDisplay('Afficher tous les comptes'),
                    child: Text('Afficher tous les comptes'),
                  ),
                  ElevatedButton(
                    onPressed: () => addToDisplay('Débiter un compte'),
                    child: Text('Débiter un compte'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => addToDisplay('Créditer un compte'),
                    child: Text('Créditer un compte'),
                  ),
                  ElevatedButton(
                    onPressed: () => addToDisplay('Effectuer un virement'),
                    child: Text('Effectuer un virement'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => addToDisplay('Quitter le programme'),
                    child: Text('Quitter le programme'),
                  ),
                  ElevatedButton(
                    onPressed: () => addToDisplay('Suspendre un compte'),
                    child: Text('Suspendre un compte'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
