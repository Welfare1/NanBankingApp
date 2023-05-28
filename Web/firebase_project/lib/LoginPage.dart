import 'package:flutter/material.dart';
import 'package:firebase_project/screens/main_body.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String welcomeMessage = '';

  void _login() {
    setState(() {
      welcomeMessage = 'Bienvenue, ${_usernameController.text} !';
    });
  }

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/nawari1.png'), // Remplacez par l'image de fond souhaitée
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
          child: Container(
            width: 400.0,
            padding: const EdgeInsets.all(16.0),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Nawari Bank',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset("images/nawari1.png", height: 40, width: 40)
                  ],
                ),
                const SizedBox(height: 24.0),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom d\'utilisateur',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    _login();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainBody(),
                        ));
                  },
                  child: const Text(
                    'Connexion',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  welcomeMessage,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
