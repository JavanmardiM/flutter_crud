import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercrud/crud/data/contact_model.dart';
import 'package:fluttercrud/crud/ui/widgets/picture_pop_up.dart';
import 'package:fluttercrud/crud/ui/widgets/star_rating.dart';
import 'package:fluttercrud/crud/utility/argument_model.dart';
import 'package:fluttercrud/crud/utility/convert_image.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsPage extends StatefulWidget {
  @override
  _ContactDetailsPageState createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  static const platform =
      const MethodChannel('flutter_contacts/launch_contacts');

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    ContactModel contact;
    contact =
        (ModalRoute.of(context).settings.arguments as ArgumentModel).object;

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('اطلاعات تماس'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: new Border.all(
                        color: Colors.grey,
                        width: 3.0,
                      )),
                  child: contact.image != null
                      ? FlatButton(
                          child: Container(
                            child: CircleAvatar(
                                backgroundImage: MemoryImage(
                                    ConvertImage.dataFromBase64String(
                                        contact.image)),
                                radius: 70.0),
                          ),
                          onPressed: () {
                            popupOpen(context, contact);
                          },
                        )
                      : CircleAvatar(
                          backgroundImage:
                              ExactAssetImage('assets/images/empty-avatar.jpg'),
                          radius: 30.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  contact.fullName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 130, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StarRating(
                          rating: contact.rate == null ? 0 : contact.rate,
                          onRatingChanged: null,
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 20, 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              ' تاریخ تولد :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: Text(contact.birthday),
                              onLongPress: () {
                                Clipboard.setData(
                                    new ClipboardData(text: contact.birthday));
                                key.currentState.showSnackBar(new SnackBar(
                                  content: new Text(" در کلیپ بورد کپی شد"),
                                ));
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'شماره تماس :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: Text(contact.phone),
                              onLongPress: () async =>
                                  _launchCaller(contact.phone),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'آدرس  :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: Text(contact.address),
                              onLongPress: () {
                                MapsLauncher.launchQuery(
                                    contact.address);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchCaller(String tell) async {
    var url = 'tel:$tell';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
