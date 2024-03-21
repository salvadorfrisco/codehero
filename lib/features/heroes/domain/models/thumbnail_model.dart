class ThumbnailModel {
  final String path;
  final String extension;

  ThumbnailModel({required this.path, required this.extension});

  factory ThumbnailModel.fromJson(Map<String, dynamic> json) {
    return ThumbnailModel(
      path: json['path'],
      extension: json['extension'],
    );
  }

  @override
  String toString() {
    return '$path.$extension';
  }
}
