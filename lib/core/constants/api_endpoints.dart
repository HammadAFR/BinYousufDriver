class EndPoints {
  static const baseUrl = 'https://riceapp.up.railway.app';

  static const signIn = '$baseUrl/accounts/signin';
  static const pendingOrders = '$baseUrl/orders/driver/pending';
  static const deliveredOrders = '$baseUrl/orders/driver/delivered';
  static const deliverOrder = '$baseUrl/orders/deliver';
  static const getAllNotifications = '$baseUrl/notifications/driver/all';
  static const getUnreadNotificationCount =
      '$baseUrl/notifications/driver/unread/count';
  static const markNotificationAsRead =
      '$baseUrl/notifications/driver/read-status';
}
