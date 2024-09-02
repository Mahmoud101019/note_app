import 'package:flutter/material.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/models/notes_model.dart';

class CardNote extends StatelessWidget {
  final void Function()? onTap;
  final Data notesModel;
  final void Function()? onDelete;
  const CardNote({
    super.key,
    required this.onTap,
    required this.onDelete,
    required this.notesModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "$linkImageName/${notesModel.notesImage}",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("${notesModel.notesTitle}"),
                subtitle: Text("${notesModel.notesContant}"),
                trailing: IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
