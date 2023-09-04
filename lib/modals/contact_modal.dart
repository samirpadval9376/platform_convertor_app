import 'dart:io';

class Contact {
  String? fullName;
  String? contact;
  String? chat;

  String? image;

  Contact({
    required this.fullName,
    required this.contact,
    required this.chat,
    this.image,
  });
}
