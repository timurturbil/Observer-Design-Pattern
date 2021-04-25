class MyModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  MyModel({this.userId, this.id, this.title, this.body});

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}