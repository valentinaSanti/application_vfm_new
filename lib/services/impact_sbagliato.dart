// import 'dart:convert';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:flutter/material.dart';
// import 'package:application_vfm_new/services/server_strings.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:application_vfm_new/utils/shared_preferences.dart';

// class ImpactService {
//   ImpactService(this.prefs);
//   Preferences prefs;
//   //serve per poterle poi utilizzare, servizio per fare chiamate unico e non rischio di avere più sezioni aperte 
  
//   //final Dio _dio = Dio(BaseOptions(baseUrl: ServerStrings.backendBaseUrl));

//   getrequest() {
//     try {
    
//     final  response =  http.get(Uri.parse(ServerStrings.backendBaseUrl));
//     }catch(e){
//       return Error();
//     }
    
    
//   }

//   Future<bool> _isImpactUp() async {

//     //Create the request
//     final url = ServerStrings.backendBaseUrl+ServerStrings.authServerUrl;

//     //Get the response
//     print('Calling: $url');
//     final response = await http.get(Uri.parse(url));

//     //Just return if the status code is OK
//     return response.statusCode == 200;
//   } //_isImpactUp

//   String? retrieveSavedToken(bool refresh) {
//     //mi rcorda preferences necessarie
//     if (refresh) {
//       return prefs.impactRefreshToken;
//     } else {
//       return prefs.impactAccessToken;
//     }
//   }

//   bool checkSavedToken({bool refresh = false}) {
//     String? token = retrieveSavedToken(refresh);
//     //Check if there is a token
//     if (token == null) {
//       return false;
//     }
//     try {
//       return ImpactService.checkToken(token);
//     } catch (_) {
//       return false;
//     }
//   }
//   static bool checkToken(String token) {
//     //Check if the token is expired
//     if (JwtDecoder.isExpired(token)) {
//       return false;
//     }
//     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

//     // //Check the iss claim FACOLTATIVO
//     // if (decodedToken['iss'] == null) {
//     //   return false;
//     // } else {
//     //   if (decodedToken['iss'] != ServerStrings.issClaim) {
//     //     return false;
//     //   } //else
//     // } //if-else

//     //Check that the user is a ricercatore
//     if (decodedToken['role'] == null) {
//       return false;
//     } else {
//       if (decodedToken['role'] != ServerStrings.patientRoleIdentifier) {
//         return false;
//       } //else
//     } //if-else

//     return true;
//   }

//   //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
//   Future<bool> getAndStoreTokens(String username, String password) async {

//     //Create the request
//     final url = ServerStrings.backendBaseUrl+ServerStrings.authServerUrl+'/token';
//     //Get the response
//     print('Calling: $url');
//     final response = await http.post(Uri.parse(url),
//     body: {'username': username, 'password': password});

//     //If response is OK, decode it and store the tokens. Otherwise do nothing.
//     if (response.statusCode == 200) {
//       final decodedResponse = jsonDecode(response.body);
//       final sp = await SharedPreferences.getInstance();
//       await sp.setString('access', decodedResponse['access']);
//       await sp.setString('refresh', decodedResponse['refresh']);
//       return true;
//     } else{//if

//     //Just return the status code
//     return false;
//     }
  
//   } //_getAndStoreTokens

//   //This method allows to refrsh the stored JWT in SharedPreferences
//   // Future<int> _refreshTokens() async {

//   //   //Create the request 
//   //   final url = ServerStrings.backendBaseUrl+;
//   //   final sp = await SharedPreferences.getInstance();
//   //   final refresh = sp.getString('refresh');
//   //   final body = {'refresh': refresh};

//   //   //Get the response
//   //   print('Calling: $url');
//   //   final response = await http.post(Uri.parse(url), body: body);

//   //   //If the response is OK, set the tokens in SharedPreferences to the new values
//   //   if (response.statusCode == 200) {
//   //     final decodedResponse = jsonDecode(response.body);
//   //     final sp = await SharedPreferences.getInstance();
//   //     await sp.setString('access', decodedResponse['access']);
//   //     await sp.setString('refresh', decodedResponse['refresh']);
//   //   } //if

//   //   //Just return the status code
//   //   return response.statusCode;
    
//   // } //_refreshTokens
// } //HomePage
