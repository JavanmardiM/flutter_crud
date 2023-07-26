import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../data/contact_model.dart';

@immutable
abstract class ContactEvent extends Equatable {
  final List props;

  ContactEvent([this.props = const []]);
}

class LoadAllContacts extends ContactEvent {}
class LoadContactsByLookUp extends ContactEvent {
  final String lookUpText;

  LoadContactsByLookUp(this.lookUpText);

  @override
  List<Object> get props => [lookUpText];
}
class LoadContact extends ContactEvent {
  final int contactId;

  LoadContact(this.contactId);

  @override
  List<Object> get props => [contactId];
}
class AddContact extends ContactEvent {
  final ContactModel contact;

  AddContact(this.contact);

  @override
  List<Object> get props => [contact];
}
class EditContact extends ContactEvent {
  final ContactModel contact;

  EditContact(this.contact);

  @override
  List<Object> get props => [contact];
}
class DeleteContact extends ContactEvent {
  final int contactId;

  DeleteContact(this.contactId);

  @override
  List<Object> get props => [contactId];
}