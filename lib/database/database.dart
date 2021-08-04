// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:test_database_floor/models/contact.dart';
import 'package:test_database_floor/models/currency.dart';
import 'package:test_database_floor/models/exchange_category.dart';
import 'package:test_database_floor/models/mix_data.dart';
import 'package:test_database_floor/models/transaction.dart';
import 'package:test_database_floor/models/wallet.dart';
import 'package:test_database_floor/services/dao/dao_contact.dart';
import 'package:test_database_floor/services/dao/dao_currency.dart';
import 'package:test_database_floor/services/dao/dao_exchange_category.dart';
import 'package:test_database_floor/services/dao/dao_transaction.dart';
import 'package:test_database_floor/services/dao/dao_wallet.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Wallet, Currency,Transaction,Contact,ExchangeCategory])
abstract class AppDatabase extends FloorDatabase {
  WalletDao get walletDao;
  CurrencyDao get currencyDao;
  TransactionDao get transactionDao;
  ExchangeCategoryDao get exchangeCategoryDao;
  ContactDao get contactDao;
}
