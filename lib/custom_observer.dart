// MANAGER
import 'dart:io';
import 'dart:math';
import 'package:challange/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

typedef ListenerObserver<T> = void Function(T model);

abstract class Observer<T> {
  Observer(this.listen);

  void update(T data);
  final ListenerObserver<T> listen;
}

abstract class Subject<R extends Observer> {
  List<R> get myItems;
  void attach(R observer);

  void notifyObserver();
}

class FetchData extends Observer<MyModel> {
  final ListenerObserver<MyModel> listen;
  FetchData(this.listen) : super(listen);
  @override
  void update(MyModel data) {
    listen(data);
  }
}

class CounterManager extends Subject<FetchData> {
  @override
  List<FetchData> myItems = [];
  MyModel newItems = MyModel(
      userId: 1,
      id: 1,
      title: "default example",
      body: "default example");
  Random random = new Random(); // I generated random value to fetch another post in each fetch process
  Future<void> fetchData() async {
    final response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
    if (response.statusCode == 200) {
      final responeData = jsonDecode(response.body);
      List<dynamic> myNewItems =
          responeData.map((e) => MyModel.fromJson(e)).toList();
      newItems = myNewItems[random.nextInt(99)];
      notifyObserver();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void attach(FetchData observer) {
    myItems.add(observer);
  }

  @override
  void notifyObserver() {
    myItems.forEach((element) {
      element.update(MyModel(
          userId: newItems.userId,
          id: newItems.id,
          title: newItems.title,
          body: newItems.body));
    });
  }
}
