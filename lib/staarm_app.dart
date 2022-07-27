import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:staarm_mobile/main.dart';

import 'app/locator.dart';
import 'core/providers/set_up.dart';
import 'core/services/navigator_service.dart';
import 'router.dart';
import 'styles/colors.dart';

class StaarmApp extends StatelessWidget {
  final bool isDebug;

  const StaarmApp({
    Key key,
    this.isDebug = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //FocusScope.of(context).requestFocus(new FocusNode());

    return MultiProvider(
      providers: providers,
      child: OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: isDebug,
          navigatorObservers: [SentryNavigatorObserver(), observer],
          title: 'Staarm',
          navigatorKey: locator<NavigationService>().navigatorKey,
          theme: ThemeData(
            fontFamily: 'PlusJakartaDisplay',
            scaffoldBackgroundColor: AppColors.appBackground,
          ),
          onGenerateRoute: StaarmRouter.generateRoute,
          initialRoute: '/',
        ),
      ),
    );
  }
}
