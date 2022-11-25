import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCredential{
  SharedPreferences? pref;
  static List<String> rank = ["인식 실패", "외부인", "재학생 지인", "재학생"];
  UserCredential(){
    setup();
  }
  void setup() async{
    pref = await SharedPreferences.getInstance();
  }
  Future<String?> getStrFromPref(String key) async{
    String? r;
    pref = await SharedPreferences.getInstance();
    r = await pref?.getString(key);
    return r;
  }
  void setStrAtPref(String key, String s) async{
    pref = await SharedPreferences.getInstance();
    pref?.setString(key, s);
  }
  Future<String?> getSession() async{
    return (await getStrFromPref("session"));
  }
  void setSession(String s) async{
    setStrAtPref("session", s);
  }
  Future<String?> getUsername() async{
    String? r = await getStrFromPref("name");
    return r;
  }
  void setUsername(String s){
    setStrAtPref("name", s);
  }
}