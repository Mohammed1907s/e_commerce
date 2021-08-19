class Category {
  late int id;
  late String nameEn;
  late String nameAr;
  late String image;
  late String imageUrl;

  Category();

Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    imageUrl = json['image_url'];
  }
  
}