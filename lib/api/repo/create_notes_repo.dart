import 'dart:convert';
import 'dart:developer';

import 'package:final_notes_swagger/api/api_handler/api_handler.dart';
import 'package:final_notes_swagger/api/base_routes/base_routes.dart';
import 'package:final_notes_swagger/api/model/res_model/TaskResModel.dart';
import 'package:final_notes_swagger/utils/api_types.dart';
import 'package:http/http.dart';

class CreateNoteRepo{

  static Future<TaskResModel?> createNoteRepo({Map<String,dynamic>? reqBody})async{

    Map<String,String> header = {
      "apiKey": "da0dea8a-e6d6-4503-bebb-988ba8c20122",
      "Content-Type":"application/json"
    };

    var response = await ApiHandler.apiHandler(
        url: BaseServiceRoutes.basePath,
        apiTypes: ApiTypes.aPost,
    header: header,reqBody: reqBody);

log("=============>${response}");
    if(response != null){
      return TaskResModel.fromJson(jsonDecode(response));
    }else{
      return null;
    }
  }
}