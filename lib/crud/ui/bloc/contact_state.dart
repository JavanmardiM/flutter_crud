import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/contact_model.dart';



@immutable
abstract class ContactState extends Equatable {
  final List props;

  ContactState([this.props = const []]);
}

class LoadingState extends ContactState {}
class ContactLoadedState extends ContactState {
  final ContactModel contact;

  ContactLoadedState(this.contact) : super([contact]);
}
class LoadedAllContactsState extends ContactState {
  final List<ContactModel> contacts;

  LoadedAllContactsState(this.contacts) : super([contacts]);
}
class LoadedContactsByLookUpState extends ContactState {
  final List<ContactModel> contacts;

  LoadedContactsByLookUpState(this.contacts) : super([contacts]);
}
class ContactAddedState extends ContactState {
  final ContactModel contact;

  ContactAddedState(this.contact) : super([contact]);
}
class ContactEditedState extends ContactState {
  final ContactModel contact;

  ContactEditedState(this.contact) : super([contact]);
}
class ContactDeletedState extends ContactState {
  final int contactId;

  ContactDeletedState(this.contactId) : super([contactId]);
}