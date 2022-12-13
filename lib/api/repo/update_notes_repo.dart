import 'dart:developer';

import 'package:final_notes_swagger/api/api_handler/api_handler.dart';
import 'package:final_notes_swagger/api/base_routes/base_routes.dart';
import 'package:final_notes_swagger/utils/api_types.dart';

class UpdateNoteRepo{

  static Future updateNoteRepo({required String? id,
    required Map<String,dynamic>? reqBody})async{

    Map<String,String> header = {
      "apiKey": "da0dea8a-e6d6-4503-bebb-988ba8c20122"
    };

    var response = await ApiHandler.apiHandler(
        url: BaseServiceRoutes.update + id!,
        apiTypes: ApiTypes.aPut,
        header: header,
        reqBody: reqBody);


    return response;

  }

}