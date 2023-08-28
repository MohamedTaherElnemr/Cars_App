class CarOrdersModel {
  late String model;
  late String name;
  late String phone;
  late String uid;
  late String dateTime;
  late String details;
  late String image;

  CarOrdersModel(
      {required this.model,
      required this.name,
      required this.phone,
      required this.uid,
      required this.dateTime,
      required this.details,
      required this.image});

  CarOrdersModel.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    name = json['name'];
    phone = json['phone'];
    uid = json['uid'];
    dateTime = json['dateTime'];
    details = json['details'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'name': name,
      'phone': phone,
      'uid': uid,
      'dateTime': dateTime,
      'details': details,
      'image': image
    };
  }
}
