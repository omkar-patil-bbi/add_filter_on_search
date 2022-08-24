
part of searching;

class Model{
  final String page;
  final String text;
  final String chapterName;
  final List<String> type;
  Model(
      this.page,
      this.text,
      this.chapterName,
      this.type,
      );
   factory Model.fromJson(Map <String, dynamic> json){
      return Model(
          json['page'] ,
          json['text'] ,
          json['chapterName'] ,
          json['type'] != null ? json['type'].cast<String>() : []
     );
   }
 }