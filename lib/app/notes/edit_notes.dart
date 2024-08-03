// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';

class EditNotesScreen extends StatefulWidget {
  final notes;
  const EditNotesScreen({super.key, this.notes});

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contantController = TextEditingController();
  Crud crud = Crud();
  bool isLoading = false;
  editNotes() async {
    if (formkey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(
        linkEditNote,
        {
          "notes_id": widget.notes['notes_id'].toString(),
          "notes_title": titleController.text,
          "notes_contant": contantController.text,
        },
      );
      isLoading = true;
      setState(() {});
      if (response['status'] == "Success") {
        Navigator.of(context).pushNamedAndRemoveUntil("Home", (route) => false);
      }
    }
  }

  @override
  void initState() {
    titleController.text = widget.notes['notes_title'];
    contantController.text = widget.notes['notes_contant'];
    super.initState();
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
                            await editNotes();
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: const Text("Edit Notes"),
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
