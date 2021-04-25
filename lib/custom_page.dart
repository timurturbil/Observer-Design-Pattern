import 'package:challange/custom_observer.dart';
import 'package:challange/model.dart';
import 'package:flutter/material.dart';

class CustomPage extends StatelessWidget {
  late final CounterManager manager;

  CustomPage() {
    manager = CounterManager();
  }
  /* CounterManager manager = CounterManager(); */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          manager.fetchData();
        },
        child: Icon(Icons.ac_unit),
      ),
      body: AppBar(
        title: TextTitle(
          initData: (data) {
            manager.attach(data);
          },
        ),
      ),
    );
  }
}

class TextTitle extends StatefulWidget {
  final void Function(FetchData data) initData;

  const TextTitle({Key? key, required this.initData}) : super(key: key);
  @override
  _TextTitleState createState() => _TextTitleState();
}

class _TextTitleState extends State<TextTitle> {
  late final FetchData counter;
  MyModel? model;
  @override
  void initState() {
    super.initState();
    counter = FetchData((data) {
      setState(() {
        model = data;
      });
    });
    widget.initData(counter);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${model?.title ?? ''}'),
      subtitle: Text('${model?.id ?? ''}'),
    );
  }
}
