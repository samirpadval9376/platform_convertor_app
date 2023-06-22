import 'package:flutter/cupertino.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: CupertinoColors.activeBlue,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CupertinoButton(
                    child: const Icon(
                      CupertinoIcons.camera,
                      color: CupertinoColors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.person,
                    ),
                    CupertinoTextFormFieldRow(
                      placeholder: 'Full Name',
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
