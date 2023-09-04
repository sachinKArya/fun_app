class JokesModel {
  int? id;
  String? jokeDes;

  JokesModel({this.id, this.jokeDes});

  JokesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    jokeDes = json['joke'] as String?;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['joke'] = jokeDes;
    return data;
  }
}
