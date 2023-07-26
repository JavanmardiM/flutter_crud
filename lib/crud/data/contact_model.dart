
import 'package:flutter/material.dart';
import 'package:fluttercrud/crud/utility/base_model.dart';
import 'dart:io';

class ContactModel extends BaseModel{
int id;
String fullName = '';
String birthday = '';
String phone = '';
String address = '';
double rate;
String image;

ContactModel(
{this.id,
  @required this.fullName,
this.birthday,
this.phone,
this.address,
this.rate,
this.image}
    ):super(id:id);

Map<String, dynamic> toMap() {
  return {
    'fullName': fullName,
    'birthday': birthday,
    'phone': phone,
    'address': address,
    'rate': rate,
    'image': image,
  };
}

static ContactModel fromMap(Map<String, dynamic> map) {
  return ContactModel(
      fullName: map['fullName'],
      birthday: map['birthday'],
      phone: map['phone'],
      address: map['address'],
      rate: map['rate'],
      image: map['image']);
}
}