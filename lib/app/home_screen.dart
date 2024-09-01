// ignore_for_file: unnecessary_null_comparison, avoid_print, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:noteapp/app/notes/edit_notes.dart';
import 'package:noteapp/components/cardnote.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/models/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Crud crud = Crud();

  getNotes() async {
    var respone = await crud.postRequest(
      linkViewNote,
      {
        "notes_user": sharedpref.getString("id"),
      },
    );
    print("data is $respone");
    return respone;
  }

  deleteNote(String notesId) async {
    var response = await crud.postRequest(
      linkDeleteNote,
      {"notes_id": notesId},
    );
    if (response['status'] == "Success") {
      Navigator.of(context).pushNamedAndRemoveUntil("Home", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Home"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                sharedpref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('login', (route) => false);
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).pushNamed("Addnotes");
          },
          elevation: 0,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == "Fail") {
                      return const Center(
                        child: Text(
                          "not have any notes",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return CardNote(
                          onDelete: () async {
                            deleteNote(snapshot.data['data'][i]['notes_id']
                                .toString());
                          },
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditNotesScreen(
                                  notes: snapshot.data['data'][i],
                                ),
                              ),
                            );
                          },
                          notesModel: Data.fromJson(snapshot.data['data'][i]),
                        );
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text("Loading........"),
                    );
                  }
                  return const Center(
                    child: Text("No Notes Have........"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
