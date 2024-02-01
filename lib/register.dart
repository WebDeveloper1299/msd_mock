import 'package:flutter/material.dart';
import 'package:msd_mock/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Insert your codes here

class MyRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mock Test  Registration Page',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  final repassword_controller = TextEditingController();
  Map<String,dynamic>FetchData={};
  String message = "Register your account";

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
          title: Text('Register!'),
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
                  child: TextField(
                    controller: repassword_controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
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
                      String repassword = repassword_controller.text;
                      if(username=="" && password =="" && repassword==""){
                        updateMessage("Please fill in all Field");
                      }
                      if(username!="" && password =="" && repassword==""){
                        updateMessage("Please fill the Field for Password and Cfm Password");

                      }
                      if(username!="" && password != repassword){
                        updateMessage("Password Do not matched");

                      }
                      if(username!="" && password== repassword){
                        if(FetchData.isEmpty){
                         FetchData.addAll({
                            "AccountName":username,
                            "AccountPassword":password,
                            "RePassword":repassword,
                          });
                          setState(() {

                          });
                          SharedPreferenceHelper.SavedSharedPreference("Data", FetchData);
                        }else{
                          for(int i =0;i<FetchData.length;i++){
                            if(FetchData["AccountName"]==username){
                              updateMessage("UserName Existed");
                              setState(() {

                              });
                              break;
                            }else if(FetchData["AccountPassword"]==password && FetchData["RePassword"]==repassword){
                              updateMessage("Password Existed ");
                              setState(() {

                              });
                              break;
                            }else{
                              FetchData.addAll({
                                "AccountName":username,
                                "AccountPassword":password,
                                "RePassword":repassword,
                              });
                              setState(() {

                              });
                              SharedPreferenceHelper.SavedSharedPreference("Data", FetchData);
                              print(FetchData);
                              updateMessage("Account Created");
                              Navigator.pushNamed(context, "/");
                              break;
                            }

                          }
                        }

                        }




                      // Insert your codes here
                    },
                    child: Text("Register"),
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
                      Navigator.pushNamed(context, "/");
                    },
                    child: Text("Cancel"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
