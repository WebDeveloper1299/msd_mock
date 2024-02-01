import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



class SharedPreferenceHelper{

  static Future<Map<String,dynamic>>GetSharedPreference(String key)async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    if(!preferences.containsKey(key)){
      return {};
    }

    String? Objjson = preferences.getString(key);

    return jsonDecode(Objjson!) as Map<String,dynamic>;



  }
  static Future<void>SavedSharedPreference(String key , Map<String,dynamic>dictionary)async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    String? objjson = jsonEncode(dictionary);
    await preferences.setString(key, objjson);
  }
}
