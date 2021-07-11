class SliderModel{
  final int id;
  final String title;
  final String message;
  final String image_url;
  final DateTime created_at;
  final DateTime updated_at;

  SliderModel(this.id, this.title, this.message, this.image_url, this.created_at, this.updated_at);

  SliderModel.fromJson(Map<String,dynamic> json)
      : id = int.parse(json['id'].toString()),
        title = json['title'],
        message = json['message'],
        image_url = json['image_url'],
        created_at = DateTime.parse(json['created_at']),
        updated_at = DateTime.parse(json['updated_at']);

  Map<String,dynamic> toJson() => {

    'id' : id,
    'title' : title,
    'message' : message,
    'image_url' : image_url,
    'created_at' : created_at,
    'updated_at' : updated_at,  };
}