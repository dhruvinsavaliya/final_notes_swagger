// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../api/model/req_model/TaskReqModel.dart';
import '../api/repo/update_notes_repo.dart';
import 'home_screen.dart';

class UpdateNoteScreen extends StatefulWidget {
  const UpdateNoteScreen(
      {Key? key,
      required this.noteTitle,
      required this.noteContent,
      required this.id})
      : super(key: key);
  final String noteTitle;
  final String noteContent;
  final String id;

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final formKey = GlobalKey<FormState>();
  TaskReqModel reqModel = TaskReqModel();
  TextEditingController? noteTitleController;

  TextEditingController? noteContentController;

  @override
  void initState() {
    String noteTitle = widget.noteTitle;
    String noteContent = widget.noteContent;
    String id = widget.id;
    noteTitleController = TextEditingController(text: noteTitle);
    noteContentController = TextEditingController(text: noteContent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        if (noteTitleController!.text.isNotEmpty &&
            noteContentController!.text.isNotEmpty) {
          reqModel.noteTitle = noteTitleController!.text;
          reqModel.noteContent = noteContentController!.text;

          await UpdateNoteRepo.updateNoteRepo(
                  id: widget.id, reqBody: reqModel.toJson())
              .then(
            (value) => Navigator.pop(context, true),
          );
        }

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Task"),
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
                      borderRadius: BorderRadius.circular(20))),
            ),
            TextFormField(
              controller: noteContentController,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                  hintText: "note",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ),
      ),
    );
  }
}
