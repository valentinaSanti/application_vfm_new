import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:application_vfm_new/services/server_strings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:application_vfm_new/utils/shared_preferences.dart';

import '../models/db.dart';

class ImpactService {
  ImpactService(this.prefs);
  Preferences prefs;
//   //serve per poterle poi utilizzare, servizio per fare chiamate unico e non rischio di avere più sezioni aperte 
  
//   //final Dio _dio = Dio(BaseOptions(baseUrl: ServerStrings.backendBaseUrl));

  getRequest() async{
    try {
    
    final  response =  await http.get(Uri.parse(ServerStrings.backendBaseUrl));
    if (response.statusCode==200){
      //la richiesta è andata a buon fine
      print(response.body);
      return true;
    }else{
      //la richiesta non ha restituito un codice diverso
      print('Errore nella richiesta: $response.statusCode');
      return false;
    }
    }catch(e){
      // si è verificato un'errore ritorna l'errore
      print('errore durante la richiesta:$e');
      return false;
    }
 }
 String? retrieveSavedToken(bool refresh) {
    //mi rcorda preferences necessarie
    if (refresh) {
      return prefs.impactRefreshToken;
    } else {
      return prefs.impactAccessToken;
    } 
  }
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
  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      return false;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return true;
  } //checkToken
  Future<bool> getTokens(String username, String password) async {
    final url = ServerStrings.backendBaseUrl+ServerStrings.authServerUrl+'/token/';
    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url),
    body: {'username': username, 'password': password});
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('access', decodedResponse['access']);
      await sp.setString('refresh', decodedResponse['refresh']);
      return true;
    } else{//if

    //Just return the status code
    return false;
    }
  }
  Future<void> getPatient() async {
         final sp = await SharedPreferences.getInstance();
    String access =  sp.getString('access')!;
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};
     dynamic r = await http.get(Uri.parse(ServerStrings.backendBaseUrl+'study/v1/patients/active/'), headers: headers);
     Map<String, dynamic> body = json.decode(r.body); 
    prefs.impactUsername =body['data'][0]['username'];
    return body['data'][0]['username'];
    //vado a vedere se un paziente, aggiorno prima paziente per fare chiamata da utorizzati poi faccio una get e poi dalla risposta prendo il primo utente, lo salvo in preferences
    //restituisco username
  }   
  Future<List<Distance>> getDistanceOfDay(DateTime startTime) async{
    final sp = await SharedPreferences.getInstance();
    String access =  sp.getString('access')!;
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};
    dynamic r = await http.get(Uri.parse(ServerStrings.backendBaseUrl+'/data/v1/distance/patients/${prefs.impactUsername}/day/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/'),headers: headers);
    Map<String, dynamic> body = json.decode(r.body); 
    List<dynamic> data = body['data']['date'];
    List<Distance> distance = body['data'][1]['data'];
    return distance;
  }
}
