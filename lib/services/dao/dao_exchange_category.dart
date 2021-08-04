// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:test_database_floor/models/exchange_category.dart';

@dao
abstract class ExchangeCategoryDao {
  @Query('SELECT * FROM ExchangeCategory')
  Future<List<ExchangeCategory>> findAllExchangeCategory();

  @Query('SELECT * FROM ExchangeCategory WHERE id = :id')
  Future<ExchangeCategory> findExchangeCategoryById(int id);

  @Query('SELECT * FROM ExchangeCategory')
  Future<List<ExchangeCategory>> retrieveExchangeCategories();

  @Query('DELETE FROM ExchangeCategory WHERE id = :id')
  Future<ExchangeCategory> deleteExchangeCategory(int id);

  @update
  Future<void> updateExchangeCategory(ExchangeCategory exchangeCategory);

  @insert
  Future<void> insertExchangeCategory(ExchangeCategory exchangeCategory);
}
