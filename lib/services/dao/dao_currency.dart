// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:test_database_floor/models/currency.dart';

@dao
abstract class CurrencyDao {
  @Query('SELECT * FROM Currency')
  Future<List<Currency>> findAllPersons();

  @Query('SELECT * FROM Currency WHERE id = :id')
  Future<Currency> findPersonById(int id);

  @Query('DELETE FROM Currency WHERE id = :id')
  Future<Currency> deleteUser(int id);

  @update
  Future<void> updateCurrency(Currency currency);

  @insert
  Future<Currency> insertPerson(Currency currency);
}
