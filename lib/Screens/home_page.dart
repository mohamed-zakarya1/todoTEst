import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_intel/Providers/todo_list_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? newTaskTitle;
    var taskObject = Provider.of<TodoListProvider>(context);
    return Scaffold(
      backgroundColor: Colors.teal[400],
      body: Container(
        padding:
        const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.playlist_add_check, size: 40, color: Colors.white),
                Text(
                  "ToDayDo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Consumer<TodoListProvider>(
              builder: (context, taskObject, child) {
                final total = taskObject.todoListModel?.tot ?? 0;
                return Text(
                  "$total Tasks",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Consumer<TodoListProvider>(
                    builder: (context, taskObject, child) {
                      final tasks = taskObject.todoListModel;

                      if (tasks == null) {
                        taskObject.getAll();
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          itemCount: tasks.models.length,
                          itemBuilder: (context, index) {
                            return  ListTile(
                              title: Text(tasks.models[index]["todo"],
                                style: const TextStyle(decoration: TextDecoration.none),
                              ),
                            );
                          },
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Add Task",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.teal[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      onChanged: (newText) {
                        newTaskTitle = newText;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if (newTaskTitle?.trim() != '') {
                          taskObject.addItems(newTaskTitle!);
                        }
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.teal[400]),
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.pink),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.red[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
