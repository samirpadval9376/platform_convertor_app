import 'package:flutter/cupertino.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoNavigationBar(),
    );
  }
}
