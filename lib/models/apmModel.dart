class Apm{
  int id;
  String name;
  String command;
  String desc;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  Apm({this.id,this.name,this.command,this.desc,this.url,this.createdAt,this.updatedAt});

  factory Apm.fromJson(Map<String,dynamic> json){
    return Apm(
      id : json['id'].toInt(),
      name : json['name'],
      command : json['command'],
      desc : json['desc'] ?? '',
      url : json['url'],
      createdAt: DateTime.parse( json['createdAt']),
      updatedAt: DateTime.parse( json['updatedAt']),
    );
  }
}