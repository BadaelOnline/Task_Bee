import 'package:floor/floor.dart';
import 'package:test_database_floor/models/currency.dart';

@Entity(tableName: 'wallet',
  primaryKeys: ['id'],
  foreignKeys: [
  ForeignKey(
    childColumns: ['currency_id'],
    parentColumns: ['id'],
    entity: Currency,
  )
],)
class Wallet {
  final int id;

  @ColumnInfo(name: 'name_wallet')
  final String name;

  @ColumnInfo(name: 'balance')
  final String balance;

  @ColumnInfo(name: 'is_active')
  final int isActive;

  @ColumnInfo(name: 'icon')
  final String icon;

  @ColumnInfo(name: 'is_appear')
  final int isAppear;

  @ColumnInfo(name: 'currency_id')
  final int currencyId;

  Wallet(this.id, this.name, this.balance, this.isActive, this.icon, this.isAppear,this.currencyId);
}
