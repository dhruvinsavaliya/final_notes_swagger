import 'dart:convert';

import 'package:final_notes_swagger/utils/api_types.dart';
import 'package:http/http.dart' as http;
class ApiHandler {
 static  http.Response? response;


  static Future apiHandler(
      {required String url,
      required ApiTypes apiTypes,
      Map<String, String>? header,
      Map<String, dynamic>? reqBody}) async {


    try {
      if(apiTypes==ApiTypes.aGet){
        response = await http.get(Uri.parse(url),headers: header);

      }
      else if(apiTypes == ApiTypes.aPost){
        response = await http.post(Uri.parse(url),headers: header, body: jsonEncode(reqBody));
      }
      else if(apiTypes == ApiTypes.aPut){
        response = await http.put(Uri.parse(url),headers: header, body: reqBody);
      }
      else {
        response = await http.delete(Uri.parse(url),headers: header, body: reqBody);
      }

      if(response!.statusCode == 200){
      return response!.body;
      }
         else if(response!.statusCode == 201){
        return response!.body;
      }
      else if(response!.statusCode == 204){
        return response!.body;
      }
      else {
        return null;
      }
    }  catch (e) {
      return null;
    }
  }
}
