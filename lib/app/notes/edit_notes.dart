// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? myfile;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contantController = TextEditingController();
  Crud crud = Crud();
  bool isLoading = false;
  editNotes() async {
    if (formkey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response;
      if (myfile == null) {
        response = await crud.postRequest(
          linkEditNote,
          {
            "notes_id": widget.notes['notes_id'].toString(),
            "notes_title": titleController.text,
            "notes_contant": contantController.text,
            "notes_image": widget.notes['notes_image'].toString(),
          },
        );
      } else {
        response = await crud.postRequestWithFile(
            linkEditNote,
            {
              "notes_id": widget.notes['notes_id'].toString(),
              "notes_title": titleController.text,
              "notes_contant": contantController.text,
              "notes_image": widget.notes['notes_image'].toString(),
            },
            myfile!);
      }

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
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                height: 190,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
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
                                        padding: const EdgeInsets.all(20),
                                        width: double.infinity,
                                        child: const Text(
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
                                        padding: const EdgeInsets.all(20),
                                        width: double.infinity,
                                        child: const Text(
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
