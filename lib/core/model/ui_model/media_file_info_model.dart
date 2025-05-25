class MediaFileInfoModel {
  int? order;
  final bool isImage;
  final String path;
  final String uploadedPath;
  String thumbnail;

  MediaFileInfoModel(
      {this.order,
      this.thumbnail = '',
      required this.isImage,
      required this.path,
      this.uploadedPath = ''});
}
