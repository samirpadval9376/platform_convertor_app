import 'package:flutter/cupertino.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return CupertinoPageScaffold(
      child: CupertinoNavigationBar(),
    );
  }
}
