class CarItemModel {
  late String model;
  late String preice;
  late String name;
  late String phone;
  late String uid;
  late String image;
  late String dateTime;

  CarItemModel(
      {required this.model,
      required this.preice,
      required this.name,
      required this.phone,
      required this.uid,
      required this.image,
      required this.dateTime});

  CarItemModel.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    preice = json['preice'];
    name = json['name'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'preice': preice,
      'name': name,
      'phone': phone,
      'uid': uid,
      'image': image,
      'dateTime': dateTime,
    };
  }
}
