// ignore_for_file: use_build_context_synchronously

import 'package:final_notes_swagger/api/repo/delete_notes_repo.dart';
import 'package:final_notes_swagger/view/update_note_screen.dart';
import 'package:flutter/material.dart';

import '../api/model/res_model/TaskResModel.dart';
import '../api/repo/get_all_notes_repo.dart';
import '../api/repo/get_notes_repo.dart';
import 'create_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskResModel> taskResModel = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await GetAllNotesRepo.getAllTaskNotesRepo();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<TaskResModel>>(
            future: GetAllNotesRepo.getAllTaskNotesRepo(),
            builder: (context, AsyncSnapshot<List<TaskResModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                taskResModel = snapshot.data!;
                // return taskResModel.isEmpty;

                return taskResModel.isEmpty
                    ? const Center(child: Text('Create New Note'))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 3),
                        itemCount: taskResModel.length,
                        itemBuilder: (context, index) {
                          var data = taskResModel[index];
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await GetTaskRepo.getTaskRepo(
                                          id: data.noteID!)
                                      .then((value) async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateNoteScreen(
                                          noteTitle: data.noteTitle.toString(),
                                          noteContent: value!.noteContent!,
                                          id: data.noteID.toString(),
                                        ),
                                      ),
                                    );

                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  child: Text(
                                    "${data.noteTitle}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  child: InkResponse(
                                    onTap: () async {
                                      await DeleteNoteRepo.deleteNoteRepo(
                                          id: data.noteID);
                                      taskResModel.removeAt(index);
                                      setState(() {});
                                    },
                                    child: Icon(Icons.close),
                                  ))
                            ],
                          );
                        },
                      );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateNoteScreen(),
              ));
        },
        child: const Icon(Icons.create_outlined),
      ),
    );
  }
}
