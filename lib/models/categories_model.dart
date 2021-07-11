class Categories{
  final int id;
  final String name;
  final String icon;
  final int user_id;
  final DateTime created_at;
  final DateTime updated_at;

  Categories(this.id, this.name, this.icon, this.user_id, this.created_at, this.updated_at);

  Categories.fromJson(Map<String,dynamic> json)
      : id = json['id'],
        name = json['name'],
        icon = json['icon'],
        user_id = json['user_id'],
        created_at = DateTime.parse(json['created_at']),
        updated_at = DateTime.parse(json['updated_at']);

  Map<String,dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'icon' : icon,
    'user_id' : user_id,
    'created_at' : created_at,
    'updated_at' : updated_at,
  };


}