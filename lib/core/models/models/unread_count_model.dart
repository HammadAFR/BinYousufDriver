class NotificationCountModel {
  int? unreadCount;

  NotificationCountModel({this.unreadCount});

  NotificationCountModel.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unread_count'] = unreadCount;
    return data;
  }
}
