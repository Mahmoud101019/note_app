import 'package:flutter/material.dart';
import 'package:noteapp/app/auth/login_screen.dart';
import 'package:noteapp/app/auth/signup_screen.dart';
import 'package:noteapp/app/auth/success.dart';
import 'package:noteapp/app/home_screen.dart';
import 'package:noteapp/app/notes/add_notes.dart';
import 'package:noteapp/app/notes/edit_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      initialRoute: sharedpref.getString("id") == null ? 'login' : 'Home',
      routes: {
        'login': (context) => const LoginScreen(),
        'Signup': (context) => const SignupScreen(),
        'Home': (context) => const HomeScreen(),
        'success': (context) => const SuccessScreen(),
        'Addnotes': (context) => const AddNotesScreen(),
        'Editnotes': (context) => const EditNotesScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
