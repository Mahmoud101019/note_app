// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Crud crud = Crud();

  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  logInFunc() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(
        logInApi,
        {
          "email": email.text.trim(),
          "password": password.text.trim(),
        },
      );
      isLoading = false;
      setState(() {});
      if (response['status'] == "Success") {
        sharedpref.setString("id", response['data']['id'].toString());
        sharedpref.setString("username", response['data']['username']);
        sharedpref.setString("email", response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil("Home", (route) => false);
      } else {
        AwesomeDialog(
          context: context,
          btnCancel: const Text("Try Agein"),
          title: "Warrning",
          body: const Text("The Email Or Password is Wrong"),
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(15),
                child: ListView(
                  children: [
                    Form(
                      key: formstate,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: 200,
                            height: 200,
                          ),
                          CustTextFormSign(
                            valid: (val) {
                              return validInput(val!, 10, 50);
                            },
                            mycontroller: email,
                            hint: "email",
                          ),
                          CustTextFormSign(
                            valid: (val) {
                              return validInput(val!, 6, 15);
                            },
                            mycontroller: password,
                            hint: "password",
                          ),
                          MaterialButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            onPressed: () async {
                              await logInFunc();
                            },
                            child: const Text("Login"),
                          ),
                          Container(height: 10),
                          InkWell(
                            child: const Text("Sign Up"),
                            onTap: () {
                              Navigator.of(context).pushNamed("Signup");
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
