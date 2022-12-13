import 'dart:convert';

import 'package:final_notes_swagger/api/api_handler/api_handler.dart';
import 'package:final_notes_swagger/api/base_routes/base_routes.dart';
import 'package:final_notes_swagger/api/model/res_model/TaskResModel.dart';
import 'package:final_notes_swagger/utils/api_types.dart';

class GetAllNotesRepo {
 static Future<List<TaskResModel>> getAllTaskNotesRepo() async {
    Map<String, String> header = {
      "apiKey": "da0dea8a-e6d6-4503-bebb-988ba8c20122"
    };

    var response = await ApiHandler.apiHandler(
        url: BaseServiceRoutes.basePath, apiTypes: ApiTypes.aGet,header: header);

    List<TaskResModel> result = List<TaskResModel>.from(
      json.decode(response).map(
            (e) => TaskResModel.fromJson(e),
          ),
    );


    return result;
  }
}
