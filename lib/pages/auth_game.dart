import 'package:flutter/material.dart';
import 'package:news_bloc_app/pages/game_screen.dart';

class AuthGaame extends StatefulWidget {
  const AuthGaame({super.key});

  @override
  State<AuthGaame> createState() => _AuthGaameState();
}

class _AuthGaameState extends State<AuthGaame> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Form(
        key: _fromKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter palyer Name',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(18),
              child: TextFormField(
                controller: player1Controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Palyer 1 name',
                    hintStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter player name 1";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: TextFormField(
                controller: player2Controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Palyer 1 name',
                    hintStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter player name 2";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                if (_fromKey.currentState!.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameScreen(
                              palyer1: player1Controller.text,
                              palyer2: player2Controller.text)));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(18)),
                padding:
                    const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                child: const Text(
                  'Start Game',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
