import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/database/database.dart';
import 'package:test_database_floor/models/currency.dart';
import 'package:test_database_floor/services/currency_cubit/states.dart';

import '../dao/dao_currency.dart';

class CurrencyCubit extends Cubit<CurrencyStates> {
  CurrencyCubit() : super(CurrencyIntialState());

  static CurrencyCubit get(context) => BlocProvider.of(context);

  AppDatabase database;
  CurrencyDao dao;
  List<Currency> currencies = [];

  void createDatabase() {
    $FloorAppDatabase
        .databaseBuilder('database_wallet.db')
        .build()
        .then((value) {
      database = value;
      dao = database.currencyDao;
      emit(CurrencyCreateDatabaseState());

      getCurrenciesFromDatabase();
    });
  }

  void getCurrenciesFromDatabase() {
    this.dao.findAllPersons().then((value) {
      currencies = value;
      emit(GetCurrenciesFromDatabaseState());
    });
  }

  void insertToDatabase({
    @required int isId,
    @required String basselName,
  }) {
    dao.insertPerson(Currency(isId, basselName, '', '')).then((value) {
      emit(InsertCurrenciesToDatabaseState());
      getCurrenciesFromDatabase();
    });
  }

  Future<void> updateCurrencyDatabase({
    @required int isId,
    @required String currencyName,
  }) {
    dao.updateCurrency(Currency(isId, currencyName, '', '')).then((value) {
      emit(UpdateCurrencyToDatabaseState());
      getCurrenciesFromDatabase();
    });
  }

  void deleteCurrencyFromDatabase({
    @required int id,
  }) {
    dao.deleteUser(id).then((value) {
      emit(DeleteCurrenciesFromDatabaseState());
      getCurrenciesFromDatabase();
    });
  }

  String getCurrencyOfWallet({
    @required int currencyId,
  }) {
    for (int i = 0; i < currencies.length; i++) {
      if (currencies[i].id == currencyId) {
        return currencies[i].name;
      }
    }
    return 'no currency for this wallet';
  }

  int getCurrencyId({
    @required String currencyName,
  }) {
    for (int i = 0; i < currencies.length; i++) {
      if (currencies[i].name == currencyName) {
        return currencies[i].id;
      }
    }
    return 0;
  }
}
