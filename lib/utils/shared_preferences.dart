import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // singleton design pattern
  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  late SharedPreferences _pref;

  Future<bool> resetSettings() async {
    return _pref.clear();
  }

  //helper method to manage default values of preferences without the need to call the specific getType method of SharedPreferences
  // utile per identificare chiavi di valori
  //tipo lingua  da selezionare o altri dati, ad esempio per salvare lingua o unità di misura imposto valore di default
  dynamic _getFromDisk(String key, {dynamic defaultVal}) {
    var value = _pref.get(key);
    if (value == null) {
      _saveToDisk(key, defaultVal);
      return defaultVal;
    } else if (value is List) {
      var val = _pref.getStringList(key);
      return val;
    }
    return value;
  }

  // helper method to call the correct setType method of SharedPreferences
  void _saveToDisk<T>(String key, T content) {
    //sceglie il metodo corretto delle preferences da chiamare
    if (content is String) {
      _pref.setString(key, content);
    }
    if (content is bool) {
      _pref.setBool(key, content);
    }
    if (content is int) {
      _pref.setInt(key, content);
    }
    if (content is double) {
      _pref.setDouble(key, content);
    }
    if (content is List<String>) {
      _pref.setStringList(key, content); // non usare per salvare liste
    }
    if (content == null) {
      _pref.remove(key);
    }
  }

  // Here we define all the keys we will need in the Preferences. We will then access the value with the getter as Preferences.key
  // The getter allows us to forget the specific string used as key in the SharedPreferences and get a list of all saved preferences as variables of the class
// imposto che quando faccio preference voglio get riporta get for disk della cosa
  String? get impactRefreshToken => _getFromDisk('impactRT');
  set impactRefreshToken(String? newImpactRefreshToken) =>
      _saveToDisk("impactRT", newImpactRefreshToken);
  // non devo ricordare che questo è una stringa faccio direttamente

  String? get impactAccessToken => _getFromDisk('impactAccessToken');
  set impactAccessToken(String? newImpactAccessToken) =>
      _saveToDisk("impactAccessToken", newImpactAccessToken);

  String? get username => _getFromDisk('username');
  set username(String? newusername) => _saveToDisk("username", newusername);

  String? get password => _getFromDisk('password');
  set password(String? newpassword) => _saveToDisk("password", newpassword);

  String? get impactUsername => _getFromDisk('impactUsername');
  set impactUsername(String? newImpactUsername) =>
      _saveToDisk("impactUsername", newImpactUsername);
}
