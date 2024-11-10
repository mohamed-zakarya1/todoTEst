import 'package:flutter/material.dart';
import 'package:todo_list_intel/Services/todo_list_services.dart';

import '../Models/todo_list_models.dart';

class TodoListProvider extends ChangeNotifier {
  TodoListModel? todoListModel;
  getAll() async{
    todoListModel = await TodoListServices.getData();
    notifyListeners();
  }
  addItems(String todo) async {
    await TodoListServices.addItems(todo: todo);
    todoListModel?.models.add({"todo":todo, "completed":false, "userId":1,});
    todoListModel?.tot += 1;
    notifyListeners();
  }
}