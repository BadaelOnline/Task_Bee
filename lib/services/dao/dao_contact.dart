// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:test_database_floor/models/contact.dart';

@dao
abstract class ContactDao {
  @Query('SELECT * FROM Contact')
  Future<List<Contact>> findAllContact();

  @Query('SELECT * FROM Contact WHERE id = :id')
  Future<Contact> findContactById(int id);

  @Query('SELECT * FROM Contact')
  Future<List<Contact>> retrieveContacts();

  @Query('DELETE FROM Contact WHERE id = :id')
  Future<Contact> deleteContact(int id);

  @update
  Future<void> updateContact(Contact contact);

  @insert
  Future<void> insertContact(Contact contact);
}
