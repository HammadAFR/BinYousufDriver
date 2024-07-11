class NotificationModel {
  String? description;
  String? id;
  String? notificationDate;
  int? status;
  int? readStatus;

  NotificationModel(
      {this.description,
      this.id,
      this.notificationDate,
      this.status,
      this.readStatus});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['_id'];
    notificationDate = json['notificationDate'];
    status = json['status'];
    readStatus = json['read_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['_id'] = id;
    data['notificationDate'] = notificationDate;
    data['status'] = status;
    data['read_status'] = readStatus;
    return data;
  }
}
