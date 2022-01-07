
class ProductModel {

  late String title;
  late String uId;
  late String image;
  late String description;
  late String dateTime;
  late bool status;

  ProductModel({
    required this.title,
    required this.uId,
    required this.image,
    required this.description,
    required this.dateTime,
    required this.status,

  });


  ProductModel.fromJson(Map <String, dynamic> json){
    title = json['title'];
    uId = json['id'];
    image = json['image'];
    description = json['description'];
    dateTime = json['dateTime'];
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    return
      {
        'title': title,
        'uId': uId,
        'image': image,
        'description': description,
        'dateTime': dateTime,
        'status': status,
      };
  }
}
