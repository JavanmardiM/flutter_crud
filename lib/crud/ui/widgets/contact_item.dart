import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttercrud/crud/data/contact_model.dart';
import 'package:fluttercrud/crud/ui/bloc/bloc.dart';
import 'package:fluttercrud/crud/ui/widgets/picture_pop_up.dart';
import 'package:fluttercrud/crud/ui/widgets/star_rating.dart';
import 'package:fluttercrud/crud/ui/widgets/ensure_delete_dialog.dart';
import 'package:fluttercrud/crud/utility/argument_model.dart';
import 'package:fluttercrud/crud/utility/convert_image.dart';
import 'package:fluttercrud/localization/lz.dart';

enum Menu { detail, delete, edit }

class ContactItem extends StatefulWidget {
  final ContactBloc contactBloc;
  final ContactModel contact;

  const ContactItem(this.contact, this.contactBloc);

  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 2, 2, 0),
      child: Card(
        child: Column(
          // align the text to the left instead of centered
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  ListTile(
                    leading: widget.contact.image != null
                        ? FlatButton(
                            child: CircleAvatar(
                                backgroundImage: MemoryImage(
                                    ConvertImage.dataFromBase64String(
                                        widget.contact.image)),
                                radius: 30.0),
                            onPressed: () {
                              popupOpen(context, widget.contact);
                            },
                          )
                        : FlatButton(
                          child: CircleAvatar(
                              backgroundImage: ExactAssetImage(
                                  'assets/images/empty-avatar.jpg'),
                              radius: 30.0),
                        ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.contact.fullName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        PopupMenuButton<Menu>(
                          onSelected: (Menu result) {
                            onSelect(result);
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<Menu>>[
                            PopupMenuItem<Menu>(
                                value: Menu.detail,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.description,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(translate(Lz.Contact_List_Contact_Item_Detail_Label)),
                                  ],
                                )),
                            PopupMenuItem<Menu>(
                                value: Menu.edit,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(translate(Lz.Contact_List_Contact_Item_Edit_Label)),
                                  ],
                                )),
                            PopupMenuItem<Menu>(
                                value: Menu.delete,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(translate(Lz.Contact_List_Contact_Item_Delete_Label)),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    translate(Lz.Contact_List_Contact_Item_Address_Label)+" : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(widget.contact.address),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    translate(Lz.Contact_List_Contact_Item_Birthday_Label)+" : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(widget.contact.birthday),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 50, 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                          child: Text(
                            translate(Lz.Contact_List_Contact_Item_Ability_Label)+" : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        StarRating(
                          rating: widget.contact.rate == null
                              ? 0
                              : widget.contact.rate,
                          onRatingChanged: null,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSelect(value) {
    if (value == Menu.delete) {
      ensureDeleteDialog(context, continueFunc: () {
        widget.contactBloc.add(DeleteContact(widget.contact.id));
      });
    } else if (value == Menu.edit) {
      Navigator.pushNamed(context, '/contact-register',
          arguments: ArgumentModel().editType(widget.contact));
    } else if (value == Menu.detail) {
      Navigator.pushNamed(context, '/contact-details',
          arguments: ArgumentModel().displayType(widget.contact));
    }
  }
}
