import 'package:equatable/equatable.dart';

class FoodModel with EquatableMixin {
  String? materials;
  String? imageUrl;
  String? description;
  int? time;
  String? title;

  FoodModel({
    this.materials,
    this.imageUrl,
    this.description,
    this.time,
    this.title,
  });

  @override
  List<Object?> get props => [materials, imageUrl, description, time, title];

  FoodModel copyWith({
    String? materials,
    String? imageUrl,
    String? description,
    int? time,
    String? title,
  }) {
    return FoodModel(
      materials: materials ?? this.materials,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      time: time ?? this.time,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'materials': materials,
      'imageUrl': imageUrl,
      'description': description,
      'time': time,
      'title': title,
    };
  }

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      materials: json['materials'] as String?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      time: json['time'] as int?,
      title: json['title'] as String?,
    );
  }
}
