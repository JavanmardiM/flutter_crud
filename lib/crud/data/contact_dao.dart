import 'package:fluttercrud/crud/data/contact_model.dart';
import 'package:sembast/sembast.dart';
import 'app_database.dart';

class ContactDao {
  static const String Contact_STORE_NAME = 'contacts';
  final _contactStore = intMapStoreFactory.store(Contact_STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<ContactModel> insert(ContactModel contact) async {
    final id = await _contactStore.add(await _db, contact.toMap());
    return getById(id);
  }

  Future<ContactModel> update(ContactModel contact) async {
    final finder = Finder(filter: Filter.byKey(contact.id));
    await _contactStore.update(
      await _db,
      contact.toMap(),
      finder: finder,
    );

    return getById(contact.id);
  }

  Future delete(int contactId) async {
    final finder = Finder(filter: Filter.byKey(contactId));
    await _contactStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<ContactModel> getById(int contactId) async {
    final finder = Finder(filter: Filter.byKey(contactId));

    final recordSnapshots = await _contactStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final contact = ContactModel.fromMap(snapshot.value);
      contact.id = snapshot.key;
      return contact;
    }).toList()[0];
  }

  Future<List<ContactModel>> getAllSortedByName() async {
    final finder = Finder(sortOrders: [
      SortOrder('fullName'),
    ]);

    final recordSnapshots = await _contactStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final contact = ContactModel.fromMap(snapshot.value);
      contact.id = snapshot.key;
      return contact;
    }).toList();
  }

  Future<List<ContactModel>> getByLookUpAndSortedByName(String lookUp) async {
    final finder = Finder(
        filter: Filter.or([Filter.matchesRegExp('fullName', RegExp(lookUp, caseSensitive: false)),
          Filter.matchesRegExp('address', RegExp(lookUp, caseSensitive: false))]),
        sortOrders: [
          SortOrder('fullName'),
        ]);

    final recordSnapshots = await _contactStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final contact = ContactModel.fromMap(snapshot.value);
      contact.id = snapshot.key;
      return contact;
    }).toList();
  }
}
