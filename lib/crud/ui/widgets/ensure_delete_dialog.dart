import 'package:flutter/material.dart';

ensureDeleteDialog(BuildContext context, {continueFunc, cancelFunc}) {

  Widget cancelButton = FlatButton(
    child: Text('انصراف'),
    onPressed: () {
      if(cancelFunc != null)
        cancelFunc();
      Navigator.pop(context);
    },
  );

  Widget continueButton = FlatButton(
    child: Text('حذف',
      style: TextStyle(
          color: Theme.of(context).colorScheme.secondary, fontSize: 16,
          fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      if(continueFunc != null)
        continueFunc();
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    content: Text('از حذف اطلاعات تماس اطمینان داری؟'),
    actions: [cancelButton, continueButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}