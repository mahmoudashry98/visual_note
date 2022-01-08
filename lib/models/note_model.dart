
class NoteModel {
  late String title;
  late String image;
  late String description;
  late String dateTime;
  late bool status=false;

  NoteModel({
    required this.title,
    required this.image,
    required this.description,
    required this.dateTime,
    required this.status,
  });

  NoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    description = json['description'];
    dateTime = json['dateTime'];
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'description': description,
      'dateTime': dateTime,
      'status': status,
    };
  }
}
