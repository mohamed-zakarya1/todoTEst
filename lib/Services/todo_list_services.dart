import 'package:dio/dio.dart';
import 'package:todo_list_intel/Models/todo_list_models.dart';

class TodoListServices {
  static Dio dio = Dio();
  static Map<String, dynamic> postData = {'todo': "", 'completed':false, 'userId':1};
  static Future<TodoListModel> getData() async {
    const url = "https://dummyjson.com/todos/user/1";
    Response response = await dio.get(url);
    return TodoListModel.fromJson(response.data);
  }
  static addItems({required String todo}) async {
    postData['todo'] = todo;
    await dio.post("https://dummyjson.com/todos/add", data: postData);
  }
}
