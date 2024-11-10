class TodoListModel {
  List<dynamic> models;
  int tot;
  TodoListModel({required this.models, required this.tot});
  factory TodoListModel.fromJson(Map<String, dynamic> json) {
    return TodoListModel(models: json["todos"], tot: json["total"]);
  }
}