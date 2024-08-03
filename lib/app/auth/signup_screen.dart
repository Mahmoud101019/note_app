// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formstate = GlobalKey();

  Crud crud = Crud();
  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signup() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(
        signUpApi,
        {
          "username": username.text.trim(),
          "email": email.text.trim(),
          "password": password.text.trim(),
        },
      );
      isLoading = false;
      setState(() {});
      if (response != null && response['status'] == "Success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      } else {
        print("Sign Up Error");
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
                              return validInput(val!, 3, 20);
                            },
                            mycontroller: username,
                            hint: "UserName",
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
                              await signup();
                            },
                            child: const Text("Sign Up"),
                          ),
                          Container(height: 10),
                          InkWell(
                            child: const Text("Login"),
                            onTap: () {
                              Navigator.of(context).pushNamed("login");
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
