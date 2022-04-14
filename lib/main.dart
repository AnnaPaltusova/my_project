import 'package:flutter/material.dart';
import 'main_page.dart';

void main() {
  runApp(MyBubble());
}
class MyBubble extends StatefulWidget {
  const MyBubble({Key? key}) : super(key: key);

  @override
  _MyBubbleState createState() => _MyBubbleState();
}
class  _MyBubbleState extends State<MyBubble> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  String _phoneNumber = '9123456789';
  final String _login = '9123456789';

  final _nameController = TextEditingController();
  final _nameLogin = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nameLogin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        borderSide: BorderSide(
            color: const Color(0xFFbbbbbb), width: 2));

    const linkTextStyle2 = TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.normal,
      color: Color(0xFF00838F),
      fontFamily: 'Hind',
    );
    const linkTextStyle3 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Color(0xFF00838F),
      fontFamily: 'Hind',
    );
    return MaterialApp(
      home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/1.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 210,),
                  Text('Введите номер телефона', style: linkTextStyle2),
                  SizedBox(height: 20,),
                  TextField(
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFeceff1),
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: 'Номер телефона',),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    obscureText: true,
                    controller: _nameLogin,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFeceff1),
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: 'Пароль',),
                  ),
                  SizedBox(height: 28,),
                  ElevatedButton(onPressed: (_submitUserForm),
                          style: ElevatedButton.styleFrom(primary: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0),)),
                            child: Text('Войти'),
                      ),
                  SizedBox(height: 32,),
                  InkWell(child: const Text('Регистрация', style: linkTextStyle3,),
                      onTap: () {}),
                  SizedBox(height: 20,),
                  InkWell(child: Text('Забыли пароль?', style: linkTextStyle3,), onTap: () {})
                ],)),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
  void _submitUserForm() {
    if ((_nameController.text.toString() == _phoneNumber) &&
        (_nameLogin.text.toString() == _login)) {
      runApp(const UserTaskScreen());
    }
    else {
      _messengerKey.currentState!.showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text('Вы ввели неверный логин или пароль', style: TextStyle(
            color: Color(0xFF00838F), fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Hind'),
        ),
      ));
    }
  }
}