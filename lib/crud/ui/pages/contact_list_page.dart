import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttercrud/crud/data/contact_model.dart';
import 'package:fluttercrud/crud/ui/widgets/contact_item.dart';
import 'package:fluttercrud/crud/ui/widgets/ensure_delete_dialog.dart';
import 'package:fluttercrud/crud/ui/widgets/no_item.dart';
import 'package:fluttercrud/crud/utility/argument_model.dart';
import 'package:fluttercrud/crud/utility/list_helper.dart';
import 'package:fluttercrud/localization/lz.dart';
import '../../ui/bloc/bloc.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  ListHelper listHelper = ListHelper(List<ContactModel>());
  TextEditingController _lookUpController = TextEditingController();

  Widget list;

  ContactBloc _contactBloc;

  bool _showSearch;

  @override
  void initState() {
    super.initState();

    _contactBloc = BlocProvider.of<ContactBloc>(context);

    _contactBloc.add(LoadAllContacts());
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;

    return BlocBuilder(
      bloc: _contactBloc,
      builder: (BuildContext context, ContactState state){
        if (state is LoadingState) {
          bodyWidget = Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedAllContactsState) {
          listHelper = ListHelper(state.contacts);
        } else if (state is LoadedContactsByLookUpState) {
          listHelper = ListHelper(state.contacts);
        } else if (state is ContactAddedState) {
          listHelper.addAtLast(state.contact);
        } else if (state is ContactEditedState) {
          listHelper.edit(state.contact);
        } else if (state is ContactDeletedState) {
          listHelper.delete(state.contactId);
        }
        bodyWidget = _buildListView();

        return Scaffold(
          appBar: _showSearch == true? _appBar(): _defaultAppBar(),
          body: bodyWidget,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, '/contact-register',
                  arguments: ArgumentModel().addType());
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  void showSearchBar() {
    setState(() {
      if(_showSearch == true){
        setState(() {
          _showSearch = false;
        });
      }else{
        setState(() {
          _showSearch = true;
        });
      }
    });
  }

  AppBar _defaultAppBar(){
    return   AppBar(
            title: Text(translate(Lz.Contact_List_App_Bar_Title)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchBar();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
          ),
        ]);

  }
  AppBar _appBar() {
    return AppBar(
        title: TextField(
          controller: _lookUpController,
          style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor, letterSpacing: 2),
          decoration: InputDecoration(
              border: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                      color: Theme.of(context).secondaryHeaderColor
                  )
              ),
              hintText: 'جستجو',
              hintStyle: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2)),
          onChanged: (String value) {
            _lookUp(value);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _lookUp(_lookUpController.text);
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              showSearchBar();
            },
          )
        ]);
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: listHelper.list.length,
      itemBuilder: (context, index) {
        final contact = listHelper.list[index];
        return listHelper.list.length != 0 ? ContactItem(contact,_contactBloc ) : NoItem();
      },
    );
  }

  _lookUp(String value) {
    if (value.isEmpty) {
      _contactBloc.add(LoadAllContacts());
    } else {
      _contactBloc.add(LoadContactsByLookUp(value));
    }
  }

}


