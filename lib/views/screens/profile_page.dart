import 'package:flutter/cupertino.dart';
import 'package:platform_convertor_app/controllers/profile_controller.dart';
import 'package:provider/provider.dart';

import '../../controllers/theme_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Container(
      color: CupertinoColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 80,
          horizontal: 20,
        ),
        child: SizedBox(
          width: s.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: s.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    CupertinoIcons.person_alt,
                  ),
                  const Spacer(),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Update Profile Data",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: Provider.of<ProfileController>(context).isActive,
                      onChanged: (val) {
                        Provider.of<ProfileController>(context, listen: false)
                            .changeProfile(val: val);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: s.height * 0.01,
              ),
              (Provider.of<ProfileController>(context).isActive)
                  ? Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: s.height * 0.18,
                            width: s.width * 0.4,
                            decoration: BoxDecoration(
                              color: CupertinoColors.activeBlue,
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: const Icon(
                              CupertinoIcons.camera,
                              color: CupertinoColors.white,
                              size: 40,
                            ),
                          ),
                          Container(
                            height: s.height * 0.05,
                            width: s.width * 0.38,
                            alignment: Alignment.center,
                            child: const CupertinoTextField.borderless(
                              placeholder: 'Enter your name',
                            ),
                          ),
                          Container(
                            height: s.height * 0.05,
                            width: s.width * 0.38,
                            alignment: Alignment.center,
                            child: const CupertinoTextField.borderless(
                              placeholder: 'Enter your bio',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoButton(
                                onPressed: () {},
                                child: const Text("SAVE"),
                              ),
                              CupertinoButton(
                                onPressed: () {},
                                child: const Text("CLEAR"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: s.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (Provider.of<ThemeController>(context, listen: false).isDark)
                      ? const Icon(
                          CupertinoIcons.sun_min_fill,
                        )
                      : const Icon(
                          CupertinoIcons.moon_fill,
                        ),
                  const Spacer(),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Theme",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Change Theme",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: Provider.of<ThemeController>(context, listen: true)
                          .isDark,
                      onChanged: (val) {
                        Provider.of<ThemeController>(context, listen: false)
                            .changeTheme();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
