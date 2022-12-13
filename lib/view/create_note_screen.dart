import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api/model/req_model/TaskReqModel.dart';
import '../api/repo/create_notes_repo.dart';
import 'home_screen.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TaskReqModel reqModel = TaskReqModel();
  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        if (noteTitleController.text.isNotEmpty &&
            noteContentController.text.isNotEmpty) {
          reqModel.noteTitle = noteTitleController.text;
          reqModel.noteContent = noteContentController.text;

          await CreateNoteRepo.createNoteRepo(reqBody: reqModel.toJson()).then(
            (value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            ),
          );
        }

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Task"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextFormField(
              controller: noteTitleController,
              maxLength: 50,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextFormField(
              controller: noteContentController,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                hintText: "note",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
