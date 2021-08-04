// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WalletDao _walletDaoInstance;

  CurrencyDao _currencyDaoInstance;

  ContactDao _contactDaoInstance;

  ExchangeCategoryDao _exchangCategoryDaoInstance;

  TransactionDao _transactionDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `wallet` (`id` INTEGER, `name_wallet` TEXT,`balance` TEXT,`icon` TEXT, `currency_id` INTEGER,`is_appear` INTEGER,`is_active` INTEGER, FOREIGN KEY (`currency_id`) REFERENCES `Currency` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Currency` (`id` INTEGER, `name` TEXT, `code` TEXT, `icon` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Contact` (`id` INTEGER, `name` TEXT,`is_appear` INTEGER,`is_active` INTEGER, PRIMARY KEY (`id`))'
        );
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `exchange_category` (`id` INTEGER, `name_exchange_category` TEXT, `icon` TEXT,`is_default` INTEGER,`is_active` INTEGER,`is_income` INTEGER, PRIMARY KEY (`id`))'
        );
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `transaction` (`id` INTEGER, `total` TEXT, `paid` TEXT, `rest` TEXT, `transaction_date` TEXT, `description` TEXT, `is_active` INTEGER, `is_appear` INTEGER, `is_income` INTEGER, `exchange_id` INTEGER, `wallet_id` INTEGER, `contact_id` INTEGER, FOREIGN KEY (`exchange_id`) REFERENCES `exchange_category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`contact_id`) REFERENCES `Contact` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))'
        ).then((value){
          print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
        }).catchError((onError){
          print('not created');
        });



        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WalletDao get walletDao {
    return _walletDaoInstance ??= _$WalletDao(database, changeListener);
  }

  @override
  CurrencyDao get currencyDao {
    return _currencyDaoInstance ??= _$CurrencyDao(database, changeListener);
  }

  @override
  ContactDao get contactDao {
   return _contactDaoInstance ??=_$ContactDao(database,changeListener);
  }

  @override
  ExchangeCategoryDao get exchangeCategoryDao {
    return _exchangCategoryDaoInstance ??= _$ExchangeCategoryDao(database,changeListener);
  }

  @override
  // TODO: implement transactionDao
  TransactionDao get transactionDao {
    return _transactionDaoInstance ??= _$TransactionDao(database,changeListener);
  }
}

class _$WalletDao extends WalletDao {
  _$WalletDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _walletInsertionAdapter = InsertionAdapter(
            database,
            'wallet',
            (Wallet item) =>
                <String, dynamic>{'id': item.id, 'name_wallet': item.name,'balance': item.balance,'icon' : item.icon,'is_active':item.isActive,'is_appear':item.isAppear,'currency_id':item.currencyId}),
        _walletUpdateAdapter = UpdateAdapter(
            database,
            'wallet',
            ['id'],
                (Wallet item) =>
            <String, Object>{'id': item.id, 'name_wallet': item.name,'balance': item.balance,'icon' : item.icon,'is_active':item.isActive,'is_appear':item.isAppear,'currency_id':item.currencyId},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Wallet> _walletInsertionAdapter;

  final UpdateAdapter<Wallet> _walletUpdateAdapter;

  @override
  Future<List<Wallet>> findAllPersons() async {
    return _queryAdapter.queryList('SELECT * FROM Wallet',
        mapper: (Map<String, dynamic> row) =>
            Wallet(row['id'] as int, row['name_wallet'] as String, row['balance'] as String, row['is_active'] as int, row['icon'] as String, row['is_appear'] as int,row['currency_id'] as int));
  }

  @override
  Future<Wallet> findPersonById(int id) async {
    return _queryAdapter.query('SELECT * FROM Wallet WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) =>
            Wallet(row['id'] as int, row['name_wallet'] as String, row['balance'] as String, row['is_active'] as int, row['icon'] as String, row['is_appear'] as int,row['currency_id'] as int));
  }

  @override
  Future<List<Wallet>> retrieveUsers() async {
    return _queryAdapter.queryList('SELECT * FROM Wallet',
        mapper: (Map<String, dynamic> row) =>
            Wallet(row['id'] as int, row['name_wallet'] as String, row['balance'] as String, row['is_active'] as int, row['icon'] as String, row['is_appear'] as int,row['currency_id'] as int));
  }

  @override
  Future<Wallet> deleteUser(int id) async {
    return _queryAdapter.query('DELETE FROM Wallet WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) =>
            Wallet(row['id'] as int, row['name_wallet'] as String, row['balance'] as String, row['is_active'] as int, row['icon'] as String, row['is_appear'] as int,row['currency_id'] as int));
  }

  @override
  Future<void> insertPerson(Wallet wallet) async {
    await _walletInsertionAdapter.insert(wallet, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateWallet(Wallet wallet) async {
    await _walletUpdateAdapter.update(wallet, OnConflictStrategy.abort);
  }
}

class _$CurrencyDao extends CurrencyDao {
  _$CurrencyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _currencyInsertionAdapter = InsertionAdapter(
            database,
            'Currency',
            (Currency item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'icon' : item.icon,'code':item.code
                }),
        _currencyUpdateAdapter = UpdateAdapter(
            database,
            'Currency',
            ['id'],
                (Currency item) =>
            <String, Object>{'id': item.id, 'name': item.name,'icon' : item.icon,'code':item.code},
            changeListener);

  final UpdateAdapter<Currency> _currencyUpdateAdapter;

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Currency> _currencyInsertionAdapter;

  @override
  Future<List<Currency>> findAllPersons() async {
    return _queryAdapter.queryList('SELECT * FROM Currency',
        mapper: (Map<String, dynamic> row) =>

            Currency(row['id'] as int, row['name'] as String, row['code'] as String, row['icon'] as String)
    );
  }

  @override
  Future<Currency> findPersonById(int id) async {
    return _queryAdapter.query('SELECT * FROM Currency WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Currency(row['id'] as int, row['name'] as String, row['code'] as String, row['icon'] as String));
  }

  @override
  Future<Currency> insertPerson(Currency currency) async {
    await _currencyInsertionAdapter.insert(currency, OnConflictStrategy.abort);
  }

  @override
  Future<Currency> deleteUser(int id) async {
    return _queryAdapter.query('DELETE FROM Currency WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) =>
            Currency(row['id'] as int, row['name'] as String, row['code'] as String, row['icon'] as String));
  }

  @override
  Future<void> updateCurrency(Currency currency) async {
    await _currencyUpdateAdapter.update(currency, OnConflictStrategy.abort);
  }
}

class _$ContactDao extends ContactDao {
  _$ContactDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _contactInsertionAdapter = InsertionAdapter(
            database,
            'Contact',
                (Contact item) => <String, dynamic>{
              'id': item.id,
              'name': item.name,
              'is_active' : item.isActive,
              'is_appear' : item.isAppear
            }),
        _contactUpdateAdapter = UpdateAdapter(
            database,
            'Contact',
            ['id'],
                (Contact item) =>
            <String, Object>{
              'id': item.id,
              'name': item.name,
              'is_active' : item.isActive,
              'is_appear' : item.isAppear
            },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Contact> _contactInsertionAdapter;

  final UpdateAdapter<Contact> _contactUpdateAdapter;

  @override
  Future<List<Contact>> findAllContact() async {
    return _queryAdapter.queryList('SELECT * FROM Contact',
        mapper: (Map<String, dynamic> row) => Contact(
            row['id'] as int, row['name'] as String, row['is_active'] as int, row['is_appear'] as int));
  }

  @override
  Future<Contact> findContactById(int id) async {
    return _queryAdapter.query('SELECT * FROM Contact WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Contact(
            row['id'] as int, row['name'] as String, row['is_active'] as int, row['is_appear'] as int));
  }

  @override
  Future<void> insertContact(Contact contact) async {
    await _contactInsertionAdapter.insert(contact, OnConflictStrategy.abort);
  }

  @override
  Future<Contact> deleteContact(int id) async {
    return _queryAdapter.query('DELETE FROM Contact WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) =>
            Contact(
                row['id'] as int, row['name'] as String, row['is_active'] as int, row['is_appear'] as int));
  }

  @override
  Future<List<Contact>> retrieveContacts() async {
    return _queryAdapter.queryList('SELECT * FROM Contact',
        mapper: (Map<String, dynamic> row) => Contact(
            row['id'] as int, row['name'] as String, row['is_active'] as int, row['is_appear'] as int));
  }

  @override
  Future<void> updateContact(Contact contact)async {
    await _contactUpdateAdapter.update(contact, OnConflictStrategy.abort);
  }
}

class _$ExchangeCategoryDao extends ExchangeCategoryDao {
  _$ExchangeCategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _exchangeInsertionAdapter = InsertionAdapter(
            database,
            'exchange_category',
                (ExchangeCategory item) => <String, dynamic>{
              'id': item.id,
              'name_exchange_category': item.name,
              'icon': item.icon,
              'is_active':item.isActive,
              'is_default':item.isDefault,
              'is_income' : item.isIncome
            }),
        _exchangeUpdateAdapter = UpdateAdapter(
            database,
            'exchange_category',
            ['id'],
                (ExchangeCategory item) =>
            <String, Object>{
              'id': item.id,
              'name_exchange_category': item.name,
              'icon': item.icon,
              'is_active':item.isActive,
              'is_default':item.isDefault,
              'is_income' : item.isIncome
            },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ExchangeCategory> _exchangeInsertionAdapter;

  final UpdateAdapter<ExchangeCategory> _exchangeUpdateAdapter;

  @override
  Future<List<ExchangeCategory>> findAllExchangeCategory() async {
    return _queryAdapter.queryList('SELECT * FROM exchange_category',
        mapper: (Map<String, dynamic> row) =>
            ExchangeCategory(row['id'] as int, row['name_exchange_category'] as String, row['is_active'] as int, row['icon'] as String,  row['is_default'] as int,   row['is_income'] as int)
            );
  }

  @override
  Future<ExchangeCategory> findExchangeCategoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM exchange_category WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => ExchangeCategory(row['id'] as int, row['name_exchange_category'] as String, row['is_active'] as int, row['icon'] as String,  row['is_default'] as int,   row['is_income'] as int)
    );
  }

  @override
  Future<void> insertExchangeCategory(ExchangeCategory exchangeCategory) async {
    await _exchangeInsertionAdapter.insert(exchangeCategory, OnConflictStrategy.abort);
  }

  @override
  Future<ExchangeCategory> deleteExchangeCategory(int id) async {
    return _queryAdapter.query('DELETE FROM exchange_category WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) =>
            ExchangeCategory(row['id'] as int, row['name_exchange_category'] as String, row['is_active'] as int, row['icon'] as String,  row['is_default'] as int,   row['is_income'] as int)
    );
  }

  @override
  Future<void> updateExchangeCategory(ExchangeCategory exchangeCategory) async {
    await _exchangeUpdateAdapter.update(exchangeCategory, OnConflictStrategy.abort);
  }

  @override
  Future<List<ExchangeCategory>> retrieveExchangeCategories() {
    return _queryAdapter.queryList('SELECT * FROM exchange_category',
        mapper: (Map<String, dynamic> row) =>
            ExchangeCategory(row['id'] as int, row['name_exchange_category'] as String, row['is_active'] as int, row['icon'] as String,  row['is_default'] as int,   row['is_income'] as int)
    );
  }
}

class _$TransactionDao extends TransactionDao {
  _$TransactionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _transactionInsertionAdapter = InsertionAdapter(
            database,
            'transaction',
                (Transaction item) => <String, dynamic>{
              'id': item.id,
              'total': item.total,
              'paid': item.paid,
              'rest': item.rest,
              'transaction_date': item.transactionDate,
              'description': item.description,
              'is_active': item.isActive,
              'is_appear': item.isAppear,
              'is_income': item.isIncome,
              'contact_id' : item.contactId,
              'wallet_id' : item.walletId,
              'exchange_id' : item.exchangeId
            }),
        _transactionUpdateAdapter = UpdateAdapter(
            database,
            'transaction',
            ['id'],
                (Transaction item) =>
            <String, Object>{'id': item.id,
              'total': item.total,
              'paid': item.paid,
              'rest': item.rest,
              'transaction_date': item.transactionDate,
              'description': item.description,
              'is_active': item.isActive,
              'is_appear': item.isAppear,
              'is_income': item.isIncome,
              'contact_id' : item.contactId,
              'wallet_id' : item.walletId,
              'exchange_id' : item.exchangeId },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Transaction> _transactionInsertionAdapter;

  final UpdateAdapter<Transaction> _transactionUpdateAdapter;

  @override
  Future<List<Transaction>> findAllTransaction() async {
    print('kkkkkkkkkkkkkkkkkkk');
    return _queryAdapter.queryList('SELECT * FROM "transaction" ',
        mapper: (Map<String, dynamic> row) =>
            Transaction(row['id'] as int,
                row['total'] as String,
                row['paid'] as String,
                row['rest'] as String,
                row['transaction_date'] as String,
                row['description'] as String,
                row['is_active'] as int,
                row['is_appear'] as int,
                row['is_income'] as int,
                row['exchange_id'] as int,
                row['wallet_id'] as int,
                row['contact_id'] as int)
            );
  }

  @override
  Future<Transaction> findTransactionById(int id) async {
    return _queryAdapter.query('SELECT * FROM transaction WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Transaction(row['id'] as int,  row['total'] as String,  row['paid'] as String,row['rest'] as String, row['transaction_date'] as String, row['description'] as String, row['isActive'] as int, row['isAppear'] as int, row['isIncome'] as int, row['exchange_id'] as int, row['wallet_id'] as int, row['contact_id'] as int));
  }

  @override
  Future<Mix> mixData() async {
    return _queryAdapter.query('SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.id = ? and w.id = ? and c.id = ? and e.id =?',
        arguments: <dynamic>[1,1,1,1],
     mapper: (Map<String, dynamic> row) =>Mix(row['id'] as int, row['name_wallet'] as String, row['name'] as String, row['name_exchange_category'] as String, row['total'] as String, row['paid'] as String, row['rest'] as String, row['description'] as String, row['is_income'] as int, row['transaction_date'] as String));

  }

  @override
  Future<List<Mix>> mixesData() async{
    return _queryAdapter.queryList('SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e where t.wallet_id=w.id and t.contact_id=c.id and t.exchange_id=e.id GROUP By t.id',
        mapper: (Map<String, dynamic> row) =>Mix(row['id'] as int, row['name_wallet'] as String, row['name'] as String, row['name_exchange_category'] as String, row['total'] as String, row['paid'] as String, row['rest'] as String, row['description'] as String, row['is_income'] as int, row['transaction_date'] as String));

  }

  @override
  Future<List<Mix>> transactionByContact(
      int contactId,
      int walletId,
      int categoryId) {
    if (contactId != 0 && walletId != 0 && categoryId != 0) {
    return _queryAdapter.queryList(
        'SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet_id=w.id and c.id = ? and w.id = ? and e.id = ? and t.contact_id=c.id and t.exchange_id=e.id GROUP BY t.id',
        arguments: <dynamic>[contactId,walletId,categoryId],
        mapper: (Map<String, dynamic> row) =>
            Mix(
                row['id'] as int,
                row['name_wallet'] as String,
                row['name'] as String,
                row['name_exchange_category'] as String,
                row['total'] as String,
                row['paid'] as String,
                row['rest'] as String,
                row['description'] as String,
                row['is_income'] as int,
                row['transaction_date'] as String));
            }else if(contactId == 0 && walletId != 0 && categoryId != 0){
      return _queryAdapter.queryList(
          'SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet_id=w.id and w.id = ? and e.id = ? and t.contact_id=c.id and t.exchange_id=e.id GROUP BY t.id',
          arguments: <dynamic>[walletId,categoryId],
          mapper: (Map<String, dynamic> row) =>
              Mix(
                  row['id'] as int,
                  row['name_wallet'] as String,
                  row['name'] as String,
                  row['name_exchange_category'] as String,
                  row['total'] as String,
                  row['paid'] as String,
                  row['rest'] as String,
                  row['description'] as String,
                  row['is_income'] as int,
                  row['transaction_date'] as String));
          }else if (contactId != 0 && walletId == 0 && categoryId != 0){
      return _queryAdapter.queryList(
          'SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet_id=w.id and c.id = ? and e.id = ? and t.contact_id=c.id and t.exchange_id=e.id GROUP BY t.id',
          arguments: <dynamic>[contactId,categoryId],
          mapper: (Map<String, dynamic> row) =>
              Mix(
                  row['id'] as int,
                  row['name_wallet'] as String,
                  row['name'] as String,
                  row['name_exchange_category'] as String,
                  row['total'] as String,
                  row['paid'] as String,
                  row['rest'] as String,
                  row['description'] as String,
                  row['is_income'] as int,
                  row['transaction_date'] as String));
        }else if (contactId != 0 && walletId != 0 && categoryId == 0) {
      return _queryAdapter.queryList(
          'SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet_id=w.id and c.id = ? and w.id = ? and t.contact_id=c.id and t.exchange_id=e.id GROUP BY t.id',
          arguments: <dynamic>[contactId,walletId],
          mapper: (Map<String, dynamic> row) =>
              Mix(
                  row['id'] as int,
                  row['name_wallet'] as String,
                  row['name'] as String,
                  row['name_exchange_category'] as String,
                  row['total'] as String,
                  row['paid'] as String,
                  row['rest'] as String,
                  row['description'] as String,
                  row['is_income'] as int,
                  row['transaction_date'] as String));
      }else if(contactId == 0 && walletId == 0 && categoryId != 0){
      return _queryAdapter.queryList(
          'SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet_id=w.id and e.id = ? and t.contact_id=c.id and t.exchange_id=e.id GROUP BY t.id',
          arguments: <dynamic>[categoryId],
          mapper: (Map<String, dynamic> row) =>
              Mix(
                  row['id'] as int,
                  row['name_wallet'] as String,
                  row['name'] as String,
                  row['name_exchange_category'] as String,
                  row['total'] as String,
                  row['paid'] as String,
                  row['rest'] as String,
                  row['description'] as String,
                  row['is_income'] as int,
                  row['transaction_date'] as String));
    }else if(contactId == 0 && walletId != 0 && categoryId == 0){
      return _queryAdapter.queryList(
          'SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet_id=w.id and w.id = ? and t.contact_id=c.id and t.exchange_id=e.id GROUP BY t.id',
          arguments: <dynamic>[walletId],
          mapper: (Map<String, dynamic> row) =>
              Mix(
                  row['id'] as int,
                  row['name_wallet'] as String,
                  row['name'] as String,
                  row['name_exchange_category'] as String,
                  row['total'] as String,
                  row['paid'] as String,
                  row['rest'] as String,
                  row['description'] as String,
                  row['is_income'] as int,
                  row['transaction_date'] as String));
    }else if(contactId != 0 && walletId == 0 && categoryId == 0){
      return _queryAdapter.queryList(
          'SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet_id=w.id and c.id = ? and t.contact_id=c.id and t.exchange_id=e.id GROUP BY t.id',
          arguments: <dynamic>[contactId],
          mapper: (Map<String, dynamic> row) =>
              Mix(
                  row['id'] as int,
                  row['name_wallet'] as String,
                  row['name'] as String,
                  row['name_exchange_category'] as String,
                  row['total'] as String,
                  row['paid'] as String,
                  row['rest'] as String,
                  row['description'] as String,
                  row['is_income'] as int,
                  row['transaction_date'] as String));
    }else{
      return _queryAdapter.queryList(
          'SELECT t.id,w.name_wallet,c.name,e.name_exchange_category,t.total,t.paid,t.rest,t.description,t.transaction_date,t.is_income FROM "transaction" t,Wallet w,Contact c,exchange_category e WHERE t.wallet_id=w.id and t.contact_id=c.id and t.exchange_id=e.id GROUP BY t.id',
          mapper: (Map<String, dynamic> row) =>
              Mix(
                  row['id'] as int,
                  row['name_wallet'] as String,
                  row['name'] as String,
                  row['name_exchange_category'] as String,
                  row['total'] as String,
                  row['paid'] as String,
                  row['rest'] as String,
                  row['description'] as String,
                  row['is_income'] as int,
                  row['transaction_date'] as String));
    }
  }

  @override
  Future<void> insertTransaction(Transaction transaction) async {
    await _transactionInsertionAdapter.insert(transaction, OnConflictStrategy.abort);
  }

  @override
  Future<Transaction> deleteTransaction(int id) async {
    return _queryAdapter.query('DELETE FROM "transaction" WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) =>
            Transaction(row['id'] as int,  row['total'] as String,  row['paid'] as String,row['rest'] as String, row['transaction_date'] as String, row['description'] as String, row['isActive'] as int, row['isAppear'] as int, row['isIncome'] as int, row['exchange_id'] as int, row['wallet_id'] as int, row['contact_id'] as int));
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    await _transactionUpdateAdapter.update(transaction, OnConflictStrategy.abort);
  }

  @override
  Future<List<Transaction>> retrieveTransactions() {
    return _queryAdapter.queryList('SELECT * FROM "transaction"',
        mapper: (Map<String, dynamic> row) =>
            Transaction(row['id'] as int,  row['total'] as String,  row['paid'] as String,row['rest'] as String, row['transaction_date'] as String, row['description'] as String, row['is_active'] as int, row['is_appear'] as int, row['is_income'] as int, row['exchange_id'] as int, row['wallet_id'] as int, row['contact_id'] as int)
    );
  }
}
