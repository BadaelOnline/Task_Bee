import 'package:floor/floor.dart';

@Entity(tableName: 'exchange_category', primaryKeys: ['id'])
class ExchangeCategory {
  final int id;

  @ColumnInfo(name: 'name_exchange_category')
  final String name;

  @ColumnInfo(name: 'icon')
  final String icon;

  @ColumnInfo(name: 'is_active')
  final int isActive;

  @ColumnInfo(name: 'is_default')
  final int isDefault;

  @ColumnInfo(name: 'is_income')
  final int isIncome;

  ExchangeCategory(this.id, this.name, this.isActive, this.icon, this.isDefault, this.isIncome);
}
