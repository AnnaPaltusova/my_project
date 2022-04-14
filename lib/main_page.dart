import 'package:flutter/material.dart';
import 'user_page.dart';
import 'task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';
import 'dart:convert';
import 'dart:async';



  Future<List<User>> _fetchUsersList() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Ошибка загрузки данных');
    }
  }

    ListView _usersListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text('${data[index].id}. ${data[index].name}', style: TextStyle(
                  color: Color(0xFF00838F),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Hind')),
              subtitle: Text('${data[index].email}', style: const TextStyle(
                  fontSize: 12, fontFamily: 'Hind', color: Color(0xFF00838F))),
              leading:
                    const Icon(
                  Icons.bubble_chart, color: Color(0xFF00838F)),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => UserTask2(user: data[index],)),
                );
              }
          );
        }
    );
  }

  class UserTaskScreen extends StatelessWidget {
  const UserTaskScreen({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    late Future<List<User>> futureUsersList = _fetchUsersList();
    late List<User> usersListData;
    return MaterialApp(
      home: Scaffold(
            appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            title: Text('Список пользователей', style: TextStyle(
                color: Color(0xFFeceff1),
                fontSize: 23,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hind'))),
        body: Center(
            child: FutureBuilder<List<User>>(
                future: futureUsersList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    usersListData = snapshot.data!;
                    return _usersListView(usersListData);
                  }
                  else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                })),

        drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [ListTile(
                leading: Icon(Icons.bubble_chart, color: Color(0xFF00838F)),
                title: Text('Настройки', style: TextStyle(
                    color: Color(0xFF00838F),
                    fontSize: 15,
                    fontFamily: 'Hind')),
                onTap: () {},
              ),
                ListTile(
                 leading: Icon(Icons.bubble_chart, color: Color(0xFF00838F)),
                 title: Text('Выход', style: TextStyle(
                     color: Color(0xFF00838F),
                     fontSize: 15,
                     fontFamily: 'Hind')),
                  onTap: () {
                   return runApp(const MyBubble());
                  },
               )]))),
         debugShowCheckedModeBanner: false,
    );
  }
  }

  /****************************************/

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

  class UserTask2 extends StatelessWidget {
  //const UserTask2({Key? key}): super (key: key);
  final User user;

  UserTask2({required this.user,});

  @override
  Widget build(BuildContext context) {
  late Future<List<Task>> userTask=_fetchTask(user.id);
  late List<Task> task;
  return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.greenAccent,
              title: Text('Список задач', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Hind'))),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("assets/1.png"),
                  fit: BoxFit.contain,
                  )),
                    child: Text('user ID:${user.id}\n'
                        'name: ${user.name}\n'
                        'username: ${user.username}\n'
                        'email: ${user.email}\n'
                        'phone: ${user.phone}\n'
                        'website: ${user.website}\n'
                        'company: ${user.company}\n',
                        //'address: ${user.address}\n
                        style: TextStyle(color: Color(0xFF00838F), fontSize: 15, fontWeight: FontWeight.normal, fontFamily: 'Hind' ),
                       )),
                    SizedBox(height: 20,),
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
                  ),)],),
          ),

          drawer: Drawer(
              child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [ListTile(
                    leading: Icon(Icons.bubble_chart, color: Color(0xFF00838F)),
                    title: Text('Настройки', style: TextStyle(
                        color: Color(0xFF00838F),
                        fontSize: 15,
                        fontFamily: 'Hind')),
                    onTap: () {},
                  ),
                    ListTile(
                      leading: Icon(Icons.bubble_chart, color: Color(0xFF00838F)),
                      title: Text('Назад', style: TextStyle(
                          color: Color(0xFF00838F),
                          fontSize: 15,
                          fontFamily: 'Hind')),
                      onTap: () {
                        return runApp(UserTaskScreen());
                      },
                    )]))),
    debugShowCheckedModeBanner: false,
  );
  }
  }
  ListView _userTask(data){
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          return ListTile(title: Column(
            children: [
              Row(
                  children: [
                  Text('${data[index].title}',),
                  Checkbox(value: data[index].completed, onChanged: (val){})
                ],
  ),
  ],
  ));
  });
}
