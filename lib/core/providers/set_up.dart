import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:staarm_mobile/ui/views/trips/view_model/activity_view_model.dart';
import 'package:staarm_mobile/ui/views/trips/view_model/history_view_model.dart';

import 'location_provider.dart';
import 'notification_provider.dart';
import 'payment_provider.dart';
import 'user_provider.dart';
import 'vehicle_provider.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider.value(value: UserProvider()),
  ChangeNotifierProvider.value(value: VehicleProvider()),
  ChangeNotifierProvider.value(value: PaymentProvider()),
  ChangeNotifierProvider.value(value: HistoryViewModel()),
  ChangeNotifierProvider.value(value: ActivityViewModel()),
  ChangeNotifierProvider.value(value: LocationProvider()),
  ChangeNotifierProvider.value(value: NotificationProvider()),
];

List<SingleChildWidget> dependentServices = [];

List<SingleChildWidget> uiConsumableProviders = [];
