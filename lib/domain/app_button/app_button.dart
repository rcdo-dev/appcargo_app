class AppButton {
  final int id;
  final String name;
  final String link;
  final String icon;
  final String color;

  AppButton(
      {this.name,
        this.color,
        this.link,
        this.icon,
        this.id});
  //Comment
  factory AppButton.fromJson(Map<String, dynamic> json) {
    return AppButton(
      id: json['id'],
      name: json['name'],
      link: json['link'],
      icon: json['icon'],
      color: json['color']
    );
  }
}