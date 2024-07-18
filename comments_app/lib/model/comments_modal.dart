
class Commetmodel {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  Commetmodel({this.postId, this.id, this.name, this.email, this.body});

  factory Commetmodel.fromJson(Map<String, dynamic> json) => Commetmodel(
        postId: json['postId'] as int?,
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        body: json['body'] as String?,
      );

 
}
