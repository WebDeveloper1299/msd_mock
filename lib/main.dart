import 'package:flutter/material.dart';
import 'package:msd_mock/register.dart';
import 'package:msd_mock/shared_preference_helper.dart';
import 'package:msd_mock/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Insert your codes here

void main() {
  runApp(const MyLoginApp());
}

class MyLoginApp extends StatelessWidget {
  const MyLoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mock Test ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: "/",
      routes: {
        "/":(BuildContext context)=>MyHomePage(title: "Login Package A Home Page"),
        "/register":(BuildContext context)=>RegisterPage(),
        "/WelcomePage":(BuildContext context)=>WelcomePage(),

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final username = "";
  final password = "";
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  Map<String,dynamic>FetchData={};
  String message = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadData();
  }
  Future<void>LoadData()async{
    FetchData = await SharedPreferenceHelper.GetSharedPreference("Data");
    setState(() {

    });
    username_controller.text=FetchData.isEmpty?null:FetchData["AccountName"];
    password_controller.text=FetchData.isEmpty?null:FetchData["AccountPassword"];

  }

  void updateMessage(String msg) {
    setState(() {
      message = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(FetchData);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    '$message',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(

                    controller: username_controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: password_controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      String username = username_controller.text;
                      String password = password_controller.text;

                      if(username == "" && password == "" || username!="" && password ==""){
                        updateMessage("Empty Field not allowed");
                      }
                      if(username!="" && password !=""){
                        for(int i =0;i<FetchData.length;i++){
                          if(FetchData["AccountName"]!=username){
                            updateMessage("Account Name not Existed");
                            break;
                          }
    if(FetchData["AccountName"]==username && FetchData["AccountPassword"]!=password) {
      updateMessage("Password Wrong");
      break;
    }
    if(FetchData["AccountName"]==username && FetchData["AccountPassword"]==password){
                            Navigator.pushNamed(context, "/WelcomePage");
                            break;
                          }
                        }
                        setState(() {

                        });
                      }
                    },
                    child: Text("Login"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
