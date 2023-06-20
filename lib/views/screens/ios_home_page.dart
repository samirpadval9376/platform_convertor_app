import 'package:flutter/cupertino.dart';
import 'package:platform_convertor_app/controllers/platform_controller.dart';
import 'package:provider/provider.dart';

class IosHomePage extends StatelessWidget {
  const IosHomePage({Key? key}) : super(key: key);

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
      child: Center(),
    );
  }
}
