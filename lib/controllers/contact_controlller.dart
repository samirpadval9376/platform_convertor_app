import 'package:flutter/cupertino.dart';
import 'package:platform_convertor_app/modals/contact_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactController extends ChangeNotifier {
  List<Contact> allContacts = [];

  List<String> allFullNames = [];
  List<String> allPhones = [];
  List<String> allChats = [];
  List<String> allImages = [];

  SharedPreferences preferences;

  ContactController({required this.preferences});

  List<Contact> get getAllContacts {
    allFullNames = preferences.getStringList('fullName') ?? [];
    allPhones = preferences.getStringList('phones') ?? [];
    allChats = preferences.getStringList('chats') ?? [];
    allImages = preferences.getStringList('images') ?? [];

    allContacts = List.generate(
      allPhones.length,
      (index) => Contact(
        fullName: allFullNames[index],
        contact: allPhones[index],
        chat: allChats[index],
        image: allImages[index],
      ),
    );

    return allContacts;
  }

  addContact({required Contact contact}) {
    allFullNames = preferences.getStringList('fullName') ?? [];
    allPhones = preferences.getStringList('phones') ?? [];
    allChats = preferences.getStringList('chats') ?? [];
    allImages = preferences.getStringList('images') ?? [];

    if (!allContacts.contains(contact)) {
      allFullNames.add(contact.fullName!);
      allPhones.add(contact.contact!);
      allChats.add(contact.chat!);
      allImages.add(contact.image!);

      preferences.setStringList('fullName', allFullNames);
      preferences.setStringList('phones', allPhones);
      preferences.setStringList('chats', allChats);
      preferences.setStringList('images', allImages);
      notifyListeners();
    }
  }
}
