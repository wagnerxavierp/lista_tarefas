class TodoModel {
  late String userId;
  late String id;
  late String title;
  late bool completed;

  TodoModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  TodoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'].toString();
    id = json['id'].toString();
    title = json['title'].toString();
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}
