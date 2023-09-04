import 'package:flutter/cupertino.dart';
import 'package:platform_convertor_app/controllers/platform_controller.dart';
import 'package:platform_convertor_app/views/screens/add_contact_page.dart';
import 'package:platform_convertor_app/views/screens/call_page.dart';
import 'package:platform_convertor_app/views/screens/chat_page.dart';
import 'package:platform_convertor_app/views/screens/profile_page.dart';
import 'package:provider/provider.dart';

class IosHomePage extends StatelessWidget {
  IosHomePage({Key? key}) : super(key: key);

  final List tabs = [
    const AddContactPage(),
    const ChatPage(),
    const CallPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Platform Convertor"),
        trailing: Consumer<PlatformController>(
          builder: (context, provider, child) => Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: provider.isAndroid,
              onChanged: (val) {
                provider.changePlatform(val: val);
              },
            ),
          ),
        ),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_add),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone),
              label: "Call",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: "Settings",
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return tabs[index];
            },
          );
        },
      ),
    );
  }
}
