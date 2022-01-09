
class AddNoteModel {
  String? id;
  late String title;
  late String image;
  late String description;
  late String dateTime;
  late bool status=false;

  AddNoteModel({
     this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.dateTime,
    required this.status,
  });

  AddNoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    image = json['image'];
    description = json['description'];
    dateTime = json['dateTime'];
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'image': image,
      'description': description,
      'dateTime': dateTime,
      'status': status,
    };
  }
}
