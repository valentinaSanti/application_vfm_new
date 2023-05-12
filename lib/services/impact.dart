import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dio/dio.dart';
import 'package:application_vfm_new/services/server_strings.dart';
import 'package:application_vfm_new/utils/shared_preferences.dart';

class ImpactService {
  ImpactService(this.prefs);
  Preferences prefs;
  //serve per poterle poi utilizzare, servizio per fare chiamate unico e non rischio di avere più sezioni aperte

  final Dio _dio = Dio(BaseOptions(baseUrl: ServerStrings.backendBaseUrl));
//pacchetto simile a http ha solo qualche struttura aggiuntiva nel nostro caso mettere http
  String? retrieveSavedToken(bool refresh) {
    //mi rcorda preferences necessarie
    if (refresh) {
      return prefs.impactRefreshToken;
    } else {
      return prefs.impactAccessToken;
    }
  }
  //con servizio devo definire metodo per fare chiamata per prendere token

  bool checkSavedToken({bool refresh = false}) {
    String? token = retrieveSavedToken(refresh);
    //Check if there is a token
    if (token == null) {
      return false;
    }
    try {
      return ImpactService.checkToken(token);
    } catch (_) {
      return false;
    }
  }

  // this method is static because we might want to check the token outside the class itself
  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      return false;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    //Check the iss claim
    if (decodedToken['iss'] == null) {
      return false;
    } else {
      if (decodedToken['iss'] != ServerStrings.issClaim) {
        return false;
      } //else
    } //if-else

    //Check that the user is a patient
    if (decodedToken['role'] == null) {
      return false;
    } else {
      if (decodedToken['role'] != ServerStrings.patientRoleIdentifier) {
        return false;
      } //else
    } //if-else

    return true;
  } //checkToken

  // make the call to get the tokens
  Future<bool> getTokens(String username, String password) async {
    try {
      Response response = await _dio.post(
          '${ServerStrings.authServerUrl}token/',
          data: {'username': username, 'password': password},
          options: Options(
              contentType: 'application/json',
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Accept": "application/json"}));
//option si possono ignorare
//faccio chiamata prendere la risposta e poi li devo salvare nelle preferenze, verifico che il token salvato nelle preferenze
//sia valido
//basta decidere il refresh dell'assets
//token prende jvt stringa la scompone stringa di mappa con info che nel nostro caso
//role iss
// devo verificare iss può essere anche evitato in questo caso inserito per verificare se compatibile con backand
//nel nostro caso serve solo verificare di fare un login con il paziente
//metodo statico perchè potrei voler richiedere nuovo token
//verificati che i token sia valido devo salvare il refresh
      if (ImpactService.checkToken(response.data['access']) &&
          ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['refresh'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //serve per fare verifica
      print(e);
      return false;
    }
  }
}
