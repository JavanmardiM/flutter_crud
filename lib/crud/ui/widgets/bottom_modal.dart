import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showModalSheet({context : BuildContext, remove : Function, selectedFromGallery: Function, selectedFromCamera: Function}) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                  child: Icon(Icons.delete,size: 50),
                  onPressed: () {
                    remove();
                  }),
              FlatButton(
                  child: Icon(
                    Icons.photo_camera,
                    size: 50,
                  ),
                onPressed: () async {
                  final image = await ImagePicker.pickImage(
                    source: ImageSource.camera,
                  );
                  selectedFromGallery(image);
                },),
              FlatButton(
                  child: Icon(
                    Icons.collections,
                    size: 50,
                  ),
                onPressed: () async {
                  final image = await ImagePicker.pickImage(
                    source: ImageSource.gallery,
                  );
                  selectedFromGallery(image);
                },),
            ],
          ),
        );
      });
}