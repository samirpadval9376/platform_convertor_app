import 'package:flutter/material.dart';
import 'package:platform_convertor_app/controllers/platform_controller.dart';
import 'package:platform_convertor_app/controllers/profile_controller.dart';
import 'package:platform_convertor_app/controllers/theme_controller.dart';
import 'package:provider/provider.dart';

import '../../modals/profile_modal.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  String? name;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Platform Convertor",
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.person_add_alt,
                ),
              ),
              Tab(
                child: Text("CHATS"),
              ),
              Tab(
                child: Text("CALLS"),
              ),
              Tab(
                child: Text("SETTING"),
              ),
            ],
          ),
          actions: [
            Consumer<PlatformController>(
              builder: (context, provider, child) => Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: provider.isAndroid,
                  onChanged: (val) {
                    provider.changePlatform(val: val);
                  },
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: TabBarView(
            children: [
              Container(
                width: s.width,
                alignment: Alignment.center,
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        child: const Icon(
                          Icons.add_a_photo_outlined,
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.03,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                          ),
                          hintText: "Full Name",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.call,
                          ),
                          hintText: "Phone Number",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.chat,
                          ),
                          hintText: "Chat Conversation",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                          ),
                          SizedBox(
                            width: s.width * 0.02,
                          ),
                          const Text("Pick Date"),
                        ],
                      ),
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                          ),
                          SizedBox(
                            width: s.width * 0.02,
                          ),
                          const Text("Pick Time"),
                        ],
                      ),
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("SAVE"),
                      ),
                    ],
                  ),
                ),
              ),
              Container(),
              Container(),
              Container(
                width: s.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: s.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.person,
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
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
                          child: Switch(
                            value: Provider.of<ProfileController>(context)
                                .isActive,
                            onChanged: (val) {
                              Provider.of<ProfileController>(context,
                                      listen: false)
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
                                CircleAvatar(
                                  radius: 70,
                                  child: const Icon(
                                    Icons.add_a_photo_outlined,
                                  ),
                                ),
                                SizedBox(
                                  height: s.height * 0.01,
                                ),
                                const Text("Enter your name..."),
                                SizedBox(
                                  height: s.height * 0.03,
                                ),
                                const Text("Enter your bio..."),
                                SizedBox(
                                  height: s.height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("SAVE"),
                                    ),
                                    SizedBox(
                                      width: s.width * 0.05,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("CLEAR"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    const Divider(),
                    SizedBox(
                      height: s.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (Provider.of<ThemeController>(context, listen: false)
                                .isDark)
                            ? const Icon(
                                Icons.light_mode,
                              )
                            : const Icon(
                                Icons.dark_mode,
                              ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Theme",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
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
                          child: Switch(
                            value: Provider.of<ThemeController>(context,
                                    listen: false)
                                .isDark,
                            onChanged: (val) {
                              Provider.of<ThemeController>(context,
                                      listen: false)
                                  .changeTheme();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
