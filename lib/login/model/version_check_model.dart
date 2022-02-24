class VersionCheckModel {
  VersionCheckModel({
    this.latest,
    this.url,
    this.isUpdate,
  });

  int? latest;
  String? url;
  bool? isUpdate;

  factory VersionCheckModel.fromJson(Map<String, dynamic> json) =>
      VersionCheckModel(
        latest: json["latest"],
        url: json["url"],
        isUpdate: json["isUpdate"] == null ? null : json["isUpdate"],
      );
}
