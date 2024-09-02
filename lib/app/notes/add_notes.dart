// ignore_for_file: use_build_context_synchronously, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? myfile;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contantController = TextEditingController();
  Crud crud = Crud();
  bool isLoading = false;
  addNotes() async {
    if (myfile == null) {
      return AwesomeDialog(
        context: context,
        title: "Warrning",
        body: Text("Please Choose Image"),
      )..show();
    }
    if (formkey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequestWithFile(
          linkAddNote,
          {
            "notes_title": titleController.text,
            "notes_contant": contantController.text,
            "notes_user": sharedpref.getString("id"),
          },
          myfile!);
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
          backgroundColor: Colors.blue,
          title: const Text("Add Notes"),
          centerTitle: true,
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
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                height: 190,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "Please Choose Image....!",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        XFile? xFile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        Navigator.of(context).pop();
                                        myfile = File(xFile!.path);
                                        setState(() {});
                                      },
                                      hoverColor: Colors.black,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(20),
                                        width: double.infinity,
                                        child: Text(
                                          "From Camera",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    //////////
                                    InkWell(
                                      onTap: () async {
                                        XFile? xFile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        Navigator.of(context).pop();
                                        myfile = File(xFile!.path);
                                        setState(() {});
                                      },
                                      hoverColor: Colors.black,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(20),
                                        width: double.infinity,
                                        child: Text(
                                          "From Gallery",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          color: myfile == null ? Colors.blue : Colors.green,
                          textColor: Colors.white,
                          child: const Text("choose Image"),
                        ),
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
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
