import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercrud/crud/ui/widgets/bottom_modal.dart';
import 'package:fluttercrud/crud/ui/widgets/picture_pop_up.dart';
import 'package:fluttercrud/crud/ui/widgets/star_rating.dart';
import 'package:fluttercrud/crud/utility/argument_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import '../../data/contact_model.dart';
import '../../ui/bloc/bloc.dart';
import 'package:fluttercrud/crud/utility/convert_image.dart';

class ContactRegisterPage extends StatefulWidget {
  @override
  _ContactRegisterPageState createState() => _ContactRegisterPageState();
}

class _ContactRegisterPageState extends State<ContactRegisterPage>
    with RouteAware {
  final _formKey = GlobalKey<FormState>();

  //--------------
  ContactBloc _contactBloc;

  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();

  ContactModel contact;
  RegisterType mode;

  //--------------

  bool returnEmpty;
  bool routeFirstLoaded = false;

  final TextEditingController textEditingController = TextEditingController();
  PersianDatePickerWidget persianDatePicker;

  @override
  void initState() {
    returnEmpty = false;
    super.initState();

    _contactBloc = BlocProvider.of<ContactBloc>(context);

    persianDatePicker = PersianDatePicker(
      controller: textEditingController,
      outputFormat: 'YYYY/MM/DD',
      onChange: (String oldText, String newText) {
        setState(() {
          _birthdayController.text = newText;
        });
      },
    ).init();
  }

  @override
  Widget build(BuildContext context) {
    if (!routeFirstLoaded) {
      mode = (ModalRoute.of(context).settings.arguments as ArgumentModel).mode;

      if (mode == RegisterType.Edit)
        contact =
            (ModalRoute.of(context).settings.arguments as ArgumentModel).object;
      else if (mode == RegisterType.Add) contact = ContactModel();

      _fullNameController.text = contact.fullName;
      _addressController.text = contact.address;
      _birthdayController.text = contact.birthday;
      _phoneController.text = contact.phone;

      routeFirstLoaded = true;
    }

    //--------------

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${mode == RegisterType.Edit ? 'ویرایش' : 'افزودن'} اطلاعات تماس'),
      ),
      body: SingleChildScrollView(child: _buildBody(contact)),
    );
  }

  Widget _buildBody(ContactModel contact) {
    if (returnEmpty) return Container();

    TextFormField fullNameInput = TextFormField(
      controller: _fullNameController,
      autofocus: true,
      keyboardType: TextInputType.text,
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'نام کاربری',
        icon: Icon(Icons.account_circle),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'لطفا نام کاربری را وارد کن.';
        }
        return null;
      },
    );
    TextFormField birthdayInput = TextFormField(
      controller: _birthdayController,
      autofocus: true,
      keyboardType: TextInputType.text,
      maxLength: 50,
      onTap: () {
        FocusScope.of(context).requestFocus(
            new FocusNode()); // to prevent opening default keyboard
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return persianDatePicker;
            });
      },
      decoration: InputDecoration(
        labelText: 'تاریخ تولد',
        icon: Icon(Icons.date_range),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'لطفا تاریخ تولد را وارد کن.';
        }
        return null;
      },
    );
    TextFormField phoneInput = TextFormField(
      controller: _phoneController,
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'شماره تماس',
        icon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'لطفا شماره تماس را وارد کن.';
        }
        return null;
      },
    );
    TextFormField addressInput = TextFormField(
//      style: TextStyle(color: Theme.of(context).primaryColor),
      controller: _addressController,
      autofocus: true,
      keyboardType: TextInputType.text,
      maxLength: 50,
      decoration: InputDecoration(
        labelText: 'آدرس',
        icon: Icon(Icons.location_on),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'لطفا آدرس را وارد کن.';
        }
        return null;
      },
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
          child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    contact.image == null
                        ? ButtonTheme(
                            minWidth: 150,
                            height: 150,
                            child: OutlineButton(
                              child: Icon(
                                Icons.add_a_photo,
                                size: 60,
                              ),
                              onPressed: pickImage,
                              shape: CircleBorder(),
                            ),
                          )
                        : Stack(alignment: Alignment.center, children: <Widget>[
                            Container(
                              child: FlatButton(
                                child: CircleAvatar(
                                    backgroundImage: MemoryImage(
                                        ConvertImage.dataFromBase64String(
                                            contact.image)),
                                    radius: 60.0),
                                onPressed: () {
                                  popupOpen(context, contact);
                                },
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(100, 90, 10, 0),
                                child: MaterialButton(
                                  height: 45,
                                  color: Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    showModalSheet(
                                        context: context,
                                        remove: () {
                                          setState(() {
                                            contact.image = null;
                                          });
                                        },
                                        selectedFromGallery: (image) {
                                          setImage(image);
                                        });
                                  },
                                  shape: CircleBorder(),
                                ),
                              ),
                            )
                          ]),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 120, 0),
                      child: StarRating(
                        rating: contact.rate == null ? 0 : contact.rate,
                        onRatingChanged: (rating) {
                          setState(() {
                            contact.rate = rating;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Column(
                        children: [
                          fullNameInput,
                          birthdayInput,
                          phoneInput,
                          addressInput,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        ButtonTheme(
                          minWidth: 160,
                          child: FlatButton(
                            child: Text('انصراف'),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/contact-list',
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ButtonTheme(
                          minWidth: 160,
                          child: RaisedButton(
                            child: Text('ذخیره'),
                            onPressed: () {
                              save();
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  save() {
    if (_formKey.currentState.validate()) {
      returnEmpty = true;

      //--------------

      contact.fullName = _fullNameController.text;
      contact.address = _addressController.text;
      contact.birthday = _birthdayController.text;
      contact.phone = _phoneController.text;

      //--------------

      if (mode == RegisterType.Edit)
        _contactBloc.add(EditContact(contact));
      else if (mode == RegisterType.Add) {
        _contactBloc.add(AddContact(contact));
      }

      Navigator.pop(context);
    }
  }

  Future pickImage() async {
    final image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      contact.image = ConvertImage.base64String(image.readAsBytesSync());
    });
  }

  Future setImage(image) async {
    setState(() {
      contact.image = ConvertImage.base64String(image.readAsBytesSync());
    });
  }
}
