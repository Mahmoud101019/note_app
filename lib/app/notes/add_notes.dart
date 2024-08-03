// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contantController = TextEditingController();
  Crud crud = Crud();
  bool isLoading = false;
  addNotes() async {
    if (formkey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(
        linkAddNote,
        {
          "notes_title": titleController.text,
          "notes_contant": contantController.text,
          "notes_user": sharedpref.getString("id"),
        },
      );
      isLoading = false;
      setState(() {});
      if (response['status'] == "Success") {
        Navigator.of(context).pushNamedAndRemoveUntil("Home", (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Notes"),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: ListView(
                    children: [
                      CustTextFormSign(
                        hint: "Notes Title",
                        mycontroller: titleController,
                        valid: (val) {
                          return validInput(val!, 1, 50);
                        },
                      ),
                      CustTextFormSign(
                        hint: "Notes Contant",
                        mycontroller: contantController,
                        valid: (val) {
                          return validInput(val!, 1, 255);
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: MaterialButton(
                          onPressed: () async {
                            await addNotes();
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: const Text("Add Notes"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
