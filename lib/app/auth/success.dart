import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("The account has been created and you can now log in"),
          ),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed("login");
            },
            child: const Text("Login"),
          )
        ],
      ),
    );
  }
}
