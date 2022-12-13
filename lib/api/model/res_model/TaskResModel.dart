class TaskResModel {
  TaskResModel({
      this.noteID, 
      this.noteTitle, 
      this.noteContent, 
      this.createDateTime, 
      this.latestEditDateTime,});

  TaskResModel.fromJson(dynamic json) {
    noteID = json['noteID'];
    noteTitle = json['noteTitle'];
    noteContent = json['noteContent'];
    createDateTime = json['createDateTime'];
    latestEditDateTime = json['latestEditDateTime'];
  }
  String? noteID;
  String? noteTitle;
  String? noteContent;
  String? createDateTime;
  dynamic latestEditDateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['noteID'] = noteID;
    map['noteTitle'] = noteTitle;
    map['noteContent'] = noteContent;
    map['createDateTime'] = createDateTime;
    map['latestEditDateTime'] = latestEditDateTime;
    return map;
  }

}