import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'task.dart';
import 'user_page.dart';
import 'package:http/http.dart' as http;
import 'main_page.dart';
import 'address.dart';
import 'user_task.dart';

Future<List<Task>> _fetchTask(int userid) async {
  final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/todos?userId=${userid}"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((task) => Task.fromJson(task)).toList();
  }
  else {
    throw Exception('Ошибка загрузки данных');
  }
}
class UserTask extends StatelessWidget {
  UserTask({Key? key, required this.user,}) : super(key: key);
  final User user;

  late Future<List<Task>> userTask = _fetchTask(user.id);

  @override
  Widget build(BuildContext context) {
    late List<Task> task;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Список задач"),),
        body: SingleChildScrollView(
          child: Column(
            children:[
              Container(
                child: Text('user ID:${user.id}\n'
                'name: ${user.name}\n'
                    'username: ${user.username}\n'
                    'email: ${user.email}\n'
                    'phone: ${user.phone}\n'
                    'website:${user.website}\n'
                    'company: ${user.company}\n'
                    //'addrees: ${user.address}'
                )),
              Center(
                child: FutureBuilder<List<Task>>(
                  future: userTask,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      task=snapshot.data!;
                      return _userTask(task);
                    }
                    else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ))
            ],
          )),
        drawer: const Drawer(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
ListView _userTask(data){
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text('${data[index].title}',));
      });
}