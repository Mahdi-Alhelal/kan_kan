class ImageModel {
  ImageModel({
    required this.id,
    required this.imageUrl,
  });
  late final int id;
  late final String imageUrl;

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    return data;
  }
}
