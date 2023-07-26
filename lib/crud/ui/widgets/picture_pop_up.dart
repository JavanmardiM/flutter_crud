import 'package:flutter/material.dart';
import 'package:fluttercrud/crud/data/contact_model.dart';
import 'package:fluttercrud/crud/utility/convert_image.dart';

popupOpen(BuildContext context, ContactModel contact) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              height: 300,
              width: 300,
              child: Container(
                child: Image.memory(ConvertImage.dataFromBase64String(
                    contact.image),fit: BoxFit.cover,),
              )),
        );
      });
}