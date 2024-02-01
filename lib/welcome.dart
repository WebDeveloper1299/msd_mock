import 'package:flutter/material.dart';
import 'package:msd_mock/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Insert your codes here

class MyWelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mock Test Welcome Page',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  //final username = "";
final password = "";
final username_controller = TextEditingController();
final password_controller = TextEditingController();
final CfmPassword = TextEditingController();

Map<String,dynamic>FetchData={};

String message = "";
void updateMessage(String msg) {
  setState(() {
    message = msg;
  });
}
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
@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome!'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children:[
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
            controller: CfmPassword,
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
                foregroundColor: Colors.white),
            onPressed: () async {
                String username = username_controller.text;
                String password = password_controller.text;
                String Repassword = CfmPassword.text;

                if(username == "" && password == "" || username!="" && password =="" && Repassword==""){
                  updateMessage("Empty Field not allowed");
                }else  if(username !="" && password != Repassword){
                  updateMessage("Password Mismatched");
                }else{
                  if(username!="" && password !="" && Repassword !=""){
                   // FetchData.containsValue(value)
                    for(int i =0;i<FetchData.length;i++){
                      if(FetchData["AccountName"]!=username){
                        updateMessage("Account Name not Existed");
                        break;
                      }else{
                        FetchData.addAll({
                          "AccountName":username,
                          "AccountPassword":password,
                          "RePassword":Repassword,
                        });
                        setState(() {

                        });
                        await SharedPreferenceHelper.SavedSharedPreference("Data", FetchData);
                        print(FetchData);
                        break;
                      }


                    }

                  }
                }


              },
                child: Text("Reset Password"),
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
                Navigator.pushNamed(context, "/");
              },
              child: Text("Logout"),
            )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("User Information", style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                 FetchData.isEmpty?SizedBox.shrink(): Card(
                    child: Container(
                      width:MediaQuery.of(context).size.width,
                      height: 100,
                      child: ListView(
                        children: [
                         ListTile(
                        title: Text("Account Name : ${FetchData["AccountName"]}"),
  subtitle: Text("Password : ${FetchData["AccountPassword"]}"),
  )
                        ],


                      ),
                    ),
                  )


                ]
            ),
          ),
        ));
  }
}
