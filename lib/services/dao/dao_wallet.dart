// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:test_database_floor/models/wallet.dart';

@dao
abstract class WalletDao {
  @Query('SELECT * FROM Wallet')
  Future<List<Wallet>> findAllPersons();

  @Query('SELECT * FROM Wallet WHERE id = :id')
  Future<Wallet> findPersonById(int id);

  @Query('SELECT * FROM Wallet')
  Future<List<Wallet>> retrieveUsers();

  @Query('DELETE FROM Wallet WHERE id = :id')
  Future<Wallet> deleteUser(int id);

  @update
  Future<void> updateWallet(Wallet wallet);

  @insert
  Future<void> insertPerson(Wallet wallet);
}
