// import 'dart:io';

// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:http/http.dart' as http;
// import 'package:application_vfm_new/utils/shared_preferences.dart';
// import 'package:application_vfm_new/services/server_strings.dart';


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

// //pacchetto simile a http ha solo qualche struttura aggiuntiva nel nostro caso mettere http
//   String? retrieveSavedToken(bool refresh) {
//     //mi rcorda preferences necessarie
//     if (refresh) {
//       return prefs.impactRefreshToken;
//     } else {
//       return prefs.impactAccessToken;
//     }
//   }
//   //con servizio devo definire metodo per fare chiamata per prendere token

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

//   // this method is static because we might want to check the token outside the class itself
//   // static bool checkToken(String token) {
//   //   //Check if the token is expired
//   //   if (JwtDecoder.isExpired(token)) {
//   //     return false;
//   //   }

//   //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

//   //   //Check the iss claim
//   //   if (decodedToken['iss'] == null) {
//   //     return false;
//   //   } else {
//   //     if (decodedToken['iss'] != ServerStrings.issClaim) {
//   //       return false;
//   //     } //else
//   //   } //if-else

//   //   //Check that the user is a patient
//   //   if (decodedToken['role'] == null) {
//   //     return false;
//   //   } else {
//   //     if (decodedToken['role'] != ServerStrings.patientRoleIdentifier) {
//   //       return false;
//   //     } //else
//   //   } //if-else

//   //   return true;
//   // } //checkToken

//   // make the call to get the tokens
//   Future<bool> getTokens(String username, String password) async {
//     //Create the request
//     final url = ServerStrings.backendBaseUrl + ServerStrings.authServerUrl;
   

//     //Get the response
//     print('Calling: $url');
//     final response = await http.post(Uri.parse(url));
//     // try {
//     //    final response = await getrequest(Uri.parse(${ServerStrings.authServerUrl}token/'));

//     //       data: {'username': username, 'password': password))'
        
      
          
          
//   //     if (ImpactService.checkToken(response.data['access']) &&
//   //         ImpactService.checkToken(response.data['refresh'])) {
//   //       prefs.impactRefreshToken = response.data['refresh'];
//   //       prefs.impactAccessToken = response.data['refresh'];
//   //       return true;
//   //     } else {
//   //       return false;
//   //     }
//   //   } catch () {
//   //     //serve per fare verifica
//   //     print(e);
//   //     return false;
//   //   }
//   // }
//   if (response.statusCode == 200) {
//       final decodedResponse = jsonDecode(response.body);
//       final sp = await SharedPreferences.getInstance();
//       await sp.setString('access', decodedResponse['access']);
//       await sp.setString('refresh', decodedResponse['refresh']);
//     } //if

//     //Just return the status code
//     return response.statusCode;
// }
