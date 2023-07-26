import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../data/contact_dao.dart';
import './bloc.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactDao _contactDao = ContactDao();

  @override
  ContactState get initialState => LoadingState();

  @override
  Stream<ContactState> mapEventToState(
      ContactEvent event,
      ) async* {
    if (event is LoadAllContacts) {
      yield LoadingState();
      final contacts = await _contactDao.getAllSortedByName();
      yield LoadedAllContactsState(contacts);
      //--------------
    } else if (event is LoadContactsByLookUp) {
      yield LoadingState();
      final contacts = await _contactDao.getByLookUpAndSortedByName(event.lookUpText);
      yield LoadedContactsByLookUpState(contacts);
      //--------------
    } else if (event is LoadContact) {
      yield LoadingState();
      final contact = await _contactDao.getById(event.contactId);
      yield ContactLoadedState(contact);
      //--------------
    }
    else if (event is AddContact) {
      yield LoadingState();
      var addedObject = await _contactDao.insert(event.contact);
      yield ContactAddedState(addedObject);
      //--------------
    }
    else if (event is EditContact) {
      yield LoadingState();
      var updatedObject = await _contactDao.update(event.contact);
      yield ContactEditedState(updatedObject);
      //--------------
    }
    else if (event is DeleteContact) {
      yield LoadingState();
      await _contactDao.delete(event.contactId);
      yield ContactDeletedState(event.contactId);
      //--------------
    }
  }
}
