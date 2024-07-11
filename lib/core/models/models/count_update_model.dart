class CountUpdateModel {
  int? readStatus;
  int? updatedCount;

  CountUpdateModel({this.readStatus, this.updatedCount});

  CountUpdateModel.fromJson(Map<String, dynamic> json) {
    readStatus = json['read_status'];
    updatedCount = json['updated_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['read_status'] = readStatus;
    data['updated_count'] = updatedCount;
    return data;
  }
}
