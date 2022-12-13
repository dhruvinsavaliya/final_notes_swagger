class TaskReqModel {

  String? noteTitle;
  String? noteContent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['noteTitle'] = noteTitle;
    map['noteContent'] = noteContent;
    return map;
  }

}