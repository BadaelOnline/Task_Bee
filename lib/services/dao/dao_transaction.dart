// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:test_database_floor/models/contact.dart';
import 'package:test_database_floor/models/mix_data.dart';
import 'package:test_database_floor/models/transaction.dart';

@dao
abstract class TransactionDao {
  @Query('SELECT * FROM transaction')
  Future<List<Transaction>> findAllTransaction();

  @Query('SELECT * FROM transaction WHERE id = :id')
  Future<Transaction> findTransactionById(int id);

  @Query('SELECT * FROM transaction')
  Future<List<Transaction>> retrieveTransactions();

  @Query('DELETE FROM transaction WHERE id = :id')
  Future<Transaction> deleteTransaction(int id);

  @update
  Future<void> updateTransaction(Transaction transaction);

  @insert
  Future<void> insertTransaction(Transaction transaction);

  @Query('SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet=w.id and t.exchange = e.id and t.contact =c.id')
  Future<Mix> mixData();

  @Query('SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet=w.id and t.exchange = e.id and t.contact =c.id')
  Future<List<Mix>> mixesData();

  @Query('SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet=w.id and t.exchange = e.id and t.contact = :contact.id')
  Future<List<Mix>> transactionByContact(int contactId,int walletId,int categoryId);
}
