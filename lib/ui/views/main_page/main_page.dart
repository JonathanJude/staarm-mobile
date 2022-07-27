import 'dart:async';

// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/managers/notification_manager.dart';
import 'package:staarm_mobile/core/managers/pusher_manager.dart';
import 'package:staarm_mobile/core/providers/notification_provider.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/hosts/home/host_home.dart';
import 'package:staarm_mobile/ui/views/profile/home/home.dart';
import 'package:staarm_mobile/ui/views/search/home/home.dart';
import 'package:staarm_mobile/ui/views/trips/home.dart';
import 'package:staarm_mobile/utils/staarm_modal_helpers.dart';
import 'package:staarm_mobile/widgets/confirm_back_tap.dart';

import '../../../main.dart';
import '../auth/login_or_signup/login_or_signup_view.dart';
import '../messages/home.dart';
import 'view_model.dart';

class MainPage extends StatefulWidget {
  final int index;

  const MainPage({Key key, this.index = 0}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState(index);
}

class _MainPageState extends State<MainPage> {
  int index;
  _MainPageState(this.index) : _currentIndex = index;
  int _currentIndex;

  @override
  initState() {
    PusherManager.init();
    super.initState();
    NotificationManager.init(
      onToken: (token) {
        bool hasSentToken = prefs.getBool("hasSentToken") ?? false;
        if (!hasSentToken) {
          Provider.of<NotificationProvider>(context, listen: false)
              .sendDeviceToken(
            token,
          );
        }
      },
    );
  }

  Future<bool> _onBackPressed() async {
    if (_currentIndex != 0) {
      setStateIfMounted(() {
        _currentIndex = 0;
      });
    }
    return false;
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  List<Widget> _children = [
    SearchHomeView(),
    TripsHomeView(),
    MessagesHomeView(),
    // GetStartedHostsView(),
    HostsHomeView(),
    ProfileHomeView(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BaseView<MainPageViewModel>(
      model: MainPageViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, _) => Consumer<UserProvider>(
        builder: (context, userProvider, _) => Scaffold(
          body: ConfirmBackTap(
              message: 'Press back again to exit',
              child: _children[_currentIndex]),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(.9),
                  width: .5,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon:
                      InActiveItem(icon: 'search', title: 'Search', size: size),
                  activeIcon:
                      ActiveItem(icon: 'search', title: 'Search', size: size),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: InActiveItem(icon: 'trips', title: 'Trips', size: size),
                  activeIcon:
                      ActiveItem(icon: 'trips', title: 'Trips', size: size),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: InActiveItem(
                      icon: 'messages', title: 'Messages', size: size),
                  activeIcon: ActiveItem(
                      icon: 'messages', title: 'Messages', size: size),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: InActiveItem(icon: 'hosts', title: 'Hosts', size: size),
                  activeIcon:
                      ActiveItem(icon: 'hosts', title: 'Hosts', size: size),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: InActiveItem(
                      icon: 'profile', title: 'Profile', size: size),
                  activeIcon:
                      ActiveItem(icon: 'profile', title: 'Profile', size: size),
                  label: '',
                ),
              ],
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (int index) async {
                if (!userProvider.isLoggedIn &&
                    index != 4 &&
                    index != 0 
                    // && index != 3
                    ) {
                  StaarmModalHelpers.fullpageModal(
                    context,
                    child: LoginOrSignupView(),
                    title: 'Log in or sign up',
                  );
                } else {
                  setStateIfMounted(() {
                    _currentIndex = index;
                  });
                }
              },
            ),
            // ),
          ),
        ),
      ),
    );
  }
}

class InActiveItem extends StatelessWidget {
  final String icon;
  final String title;
  final Size size;
  final double iconSize;
  final double textFontSize;

  const InActiveItem({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.size,
    this.iconSize = 23,
    this.textFontSize = 12,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Opacity(
            opacity: .5,
            child: Image.asset(
              'assets/images/menu_icons/${icon}_inactive.png',
              height: iconSize,
            ),
          ),
        ),
        title.isEmpty
            ? ''
            : Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      title ?? ' ',
                      style: TextStyle(
                          fontSize: textFontSize,
                          color: Color(0xFF202046).withOpacity(.5),
                          fontWeight: FontWeight.w400),
                    )),
              )
      ],
    );
  }
}

class ActiveItem extends StatelessWidget {
  final String icon;
  final String title;
  final Size size;
  final double iconSize;
  final double textFontSize;

  const ActiveItem(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.size,
      this.iconSize = 23,
      this.textFontSize = 12})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Icon(icon, size: iconSize, color: Color(0xFF6B42DD)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Image.asset(
            'assets/images/menu_icons/${icon}_active.png',
            height: iconSize,
          ),
        ),
        title.isEmpty
            ? ''
            : Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: textFontSize,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
              )
      ],
    );
  }
}

class TextWidget extends StatelessWidget {
  final String data;

  const TextWidget({Key key, @required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(data)),
    );
  }
}
