import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../view/Auth/auth_view_model.dart';
import '../../view/Deliver Order/deliver_view_model.dart';
import '../../view/Home/home_screen_view_model.dart';
import '../../view/Notification/notifications_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthViewModel()),
  ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
  ChangeNotifierProvider(create: (_) => DeliverViewModel()),
  ChangeNotifierProvider(create: (_) => NotificationsViewModel()),
];
