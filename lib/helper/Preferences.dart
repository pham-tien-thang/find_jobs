import 'package:shared_preferences/shared_preferences.dart';
removeValues () async {
  SharedPreferences prefs =  await  SharedPreferences . getInstance ();
  // Xóa chuỗi
  prefs.remove("phone");
  prefs.remove("email");
  prefs.remove("password");
  prefs.remove("id");
  prefs.remove("name");
}
remove_r()async{
  SharedPreferences prefs =  await  SharedPreferences . getInstance ();
  prefs.remove("remember_mail");
  prefs.remove("remember_pass");
}
//class
class SharedPrefs {
  static SharedPreferences _sharedPrefs;
//create
  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }
  //add
  addStringToSF(String id, String fullName,String password,String email,String phone) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.setString('id', id);
    _sharedPrefs.setString('fullName', fullName);
    _sharedPrefs.setString('password', password);
    _sharedPrefs.setString('email', email);
    _sharedPrefs.setString('phone', phone);
  }
  remember(String mail,String pass,bool save){
    _sharedPrefs.setString('remember_mail', mail);
    _sharedPrefs.setString('remember_pass', pass);
    _sharedPrefs.setBool('save', save);
  }
  String get user_id => _sharedPrefs.getString('id');
  String get email => _sharedPrefs.getString('email');
  String get fullName => _sharedPrefs.getString('fullName');
  String get phone => _sharedPrefs.getString('phone');
  bool get check => _sharedPrefs.containsKey('id');
  String get r_mail => _sharedPrefs.getString('remember_mail');
  String get r_pass => _sharedPrefs.getString('remember_pass');
  bool get r_save => _sharedPrefs.containsKey('save');
  bool get r_save_value => _sharedPrefs.getBool('save');
}

final sharedPrefs = SharedPrefs();