import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/database/database.dart';
import 'package:test_database_floor/models/exchange_category.dart';
import 'package:test_database_floor/services/dao/dao_exchange_category.dart';
import 'package:test_database_floor/services/exchange_cubit/states.dart';

class ExchangeCubit extends Cubit<ExchangeStates> {
  ExchangeCubit() : super(ExchangeIntialState());

  static ExchangeCubit get(context) => BlocProvider.of(context);

  AppDatabase database;
  ExchangeCategoryDao dao;
  List<ExchangeCategory> exchanges = [];
  int lastId;

  void createDatabase() {
    $FloorAppDatabase
        .databaseBuilder('database_wallet.db')
        .build()
        .then((value) {
      database = value;
      dao = database.exchangeCategoryDao;
      emit(ExchangeCreateDatabaseState());

      getExchangesFromDatabase();
    });
  }

  void getExchangesFromDatabase() {
    this.dao.retrieveExchangeCategories().then((value) {
      exchanges = value;
      if (value.length > 0) {
        lastId = value[value.length - 1].id;
      } else {
        lastId = 0;
      }

      emit(GetExchangesFromDatabaseState());
    });
  }

  Future<void> insertToDatabase(
      {@required int isId,
      @required String exchangeName,
      @required String catImage}) {
    dao
        .insertExchangeCategory(
            ExchangeCategory(isId, exchangeName, 1, catImage, 0, 1))
        .then((value) {
      emit(InsertExchangesToDatabaseState());
      getExchangesFromDatabase();
    });
  }

  Future<void> updateExchangeDatabase({
    @required int isId,
    @required String exchangeName,
    @required String icon,
  }) {
    dao
        .updateExchangeCategory(
            ExchangeCategory(isId, exchangeName, 1, icon, 0, 1))
        .then((value) {
      emit(UpdateExchangesToDatabaseState());
      getExchangesFromDatabase();
    });
  }

  void deleteExchangeFromDatabase({
    @required int id,
  }) {
    dao.deleteExchangeCategory(id).then((value) {
      emit(DeleteExchangesFromDatabaseState());
      getExchangesFromDatabase();
    });
  }

  int getExchangeId({
    @required String exchangeName,
  }) {
    for (int i = 0; i < exchanges.length; i++) {
      if (exchanges[i].name == exchangeName) {
        return exchanges[i].id;
      }
    }
    return 0;
  }
}
