import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:platform_convertor_app/controllers/contact_controlller.dart';
import 'package:platform_convertor_app/controllers/date_time_controller.dart';
import 'package:platform_convertor_app/controllers/platform_controller.dart';
import 'package:platform_convertor_app/controllers/profile_controller.dart';
import 'package:platform_convertor_app/controllers/theme_controller.dart';
import 'package:platform_convertor_app/modals/contact_modal.dart';
import 'package:platform_convertor_app/modals/globals.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modals/profile_modal.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  String? fullName;
  String? contact;
  String? chat;
  File? image;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Platform Convertor",
            style: TextStyle(
              fontSize: 22,
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
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: s.width,
                  alignment: Alignment.center,
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<PlatformController>(
                            builder: (context, provider, child) {
                          return CircleAvatar(
                            foregroundImage: provider.image != null
                                ? FileImage(provider.image!)
                                : null,
                            radius: 70,
                            child: IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Select Method !!"),
                                    actions: [
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          ImagePicker picker = ImagePicker();

                                          XFile? img = await picker.pickImage(
                                            source: ImageSource.camera,
                                          );

                                          if (img != null) {
                                            provider.addImage(
                                              img: File(
                                                img.path,
                                              ),
                                            );
                                          }
                                        },
                                        icon: const Icon(Icons.camera_alt),
                                        label: const Text("Camera"),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          ImagePicker picker = ImagePicker();

                                          XFile? img = await picker.pickImage(
                                            source: ImageSource.gallery,
                                          );

                                          if (img != null) {
                                            provider.addImage(
                                              img: File(
                                                img.path,
                                              ),
                                            );
                                          }
                                        },
                                        icon: const Icon(Icons.image),
                                        label: const Text("Gallery"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.add_a_photo_outlined,
                              ),
                            ),
                          );
                        }),
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
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the name";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            fullName = val;
                          },
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
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the number";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            contact = val;
                          },
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
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the chat";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            chat = val!;
                          },
                        ),
                        SizedBox(
                          height: s.height * 0.01,
                        ),
                        Consumer<DateTimeController>(
                          builder: (context, provider, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    DateTime? d = await showDatePicker(
                                      context: context,
                                      initialDate: provider.dateTime!,
                                      firstDate: DateTime(2023),
                                      lastDate: DateTime.now().add(
                                        const Duration(
                                          days: 1,
                                        ),
                                      ),
                                    );

                                    if (d != null) {
                                      provider.dateChanged(date: d);
                                    }
                                  },
                                  icon: const Icon(Icons.calendar_month),
                                ),
                                const Text("Pick Date"),
                                SizedBox(
                                  width: s.width * 0.44,
                                ),
                                Text(
                                    "${provider.dateTime!.day}/${provider.dateTime!.month}/${provider.dateTime!.year}"),
                              ],
                            );
                          },
                        ),
                        Consumer<DateTimeController>(
                          builder: (context, provider, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    TimeOfDay? time = await showTimePicker(
                                      context: context,
                                      initialTime: provider.timeOfDay!,
                                    );

                                    provider.timeChanged(time: time!);
                                  },
                                  icon: const Icon(Icons.access_time),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: provider.timeController,
                                    decoration: const InputDecoration(
                                      hintText: "Pick Time",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${(provider.timeOfDay!.hour % 12).toString().padLeft(2, '0')}:${(provider.timeOfDay!.minute).toString().padLeft(2, '0')} ${(provider.timeOfDay!.hour >= 12) ? 'PM' : 'AM'}",
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: s.height * 0.02,
                        ),
                        Consumer<ContactController>(
                            builder: (context, provider, child) {
                          return ElevatedButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();

                                Directory? dir =
                                    await getExternalStorageDirectory();

                                File imagePath =
                                    await Provider.of<PlatformController>(
                                            context,
                                            listen: false)
                                        .image!
                                        .copy("${dir!.path}/$fullName.jpg");

                                provider.addContact(
                                  contact: Contact(
                                    fullName: fullName,
                                    contact: contact,
                                    chat: chat,
                                    image: imagePath.path,
                                  ),
                                );
                              }
                            },
                            child: const Text("SAVE"),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: s.width,
                child: Consumer<ContactController>(
                  builder: (context, provider, child) {
                    return ListView.builder(
                      itemCount: provider.getAllContacts.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          foregroundImage: FileImage(
                            File(
                              provider.getAllContacts[index].image!,
                            ),
                          ),
                        ),
                        title:
                            Text("${provider.getAllContacts[index].fullName}"),
                        subtitle:
                            Text("${provider.getAllContacts[index].chat}"),
                        trailing: Consumer<DateTimeController>(
                          builder: (context, pro, child) {
                            return Text(
                              "${pro.dateTime!.day}/${pro.dateTime!.month}/${pro.dateTime!.year} , ${pro.timeOfDay!.hour}:${pro.timeOfDay!.minute}",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: s.width,
                child: Consumer<ContactController>(
                    builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.getAllContacts.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        foregroundImage: FileImage(
                          File(
                            provider.getAllContacts[index].image!,
                          ),
                        ),
                      ),
                      title: Text("${provider.getAllContacts[index].fullName}"),
                      subtitle:
                          Text("+91 ${provider.getAllContacts[index].contact}"),
                      trailing: IconButton(
                        onPressed: () async {
                          Uri uri = Uri(
                            scheme: 'tel',
                            path: provider.getAllContacts[index].contact,
                          );
                          await launchUrl(uri);
                        },
                        icon: const Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
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
                                const CircleAvatar(
                                  radius: 70,
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                  ),
                                ),
                                SizedBox(
                                  height: s.height * 0.01,
                                ),
                                Container(
                                  height: s.height * 0.05,
                                  width: s.width * 0.4,
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Enter your name",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: s.height * 0.05,
                                  width: s.width * 0.4,
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Enter your bio",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: s.height * 0.01,
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
