import 'dart:convert';
import '../../utils/api_types.dart';
import '../api_handler/api_handler.dart';
import '../base_routes/base_routes.dart';
import '../model/res_model/TaskResModel.dart';

class GetTaskRepo {
  static Future<TaskResModel?> getTaskRepo({required String? id}) async {
    Map<String, String> header = {
      "apiKey": "da0dea8a-e6d6-4503-bebb-988ba8c20122"
    };

    String url = BaseServiceRoutes.update + id!;
    var response = await ApiHandler.apiHandler(
        url: url, apiTypes: ApiTypes.aGet, header: header);

    if (response != null) {
      return TaskResModel.fromJson(jsonDecode(response));
    } else {
      return null;
    }
  }
}
