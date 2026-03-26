import 'package:a1_check_cashers/features/drawer/data/data_sources/drawer_local_data.dart';
import 'package:a1_check_cashers/features/drawer/domain/entities/drawer_entity.dart';
import 'package:flutter/material.dart';

class DrawerProvider extends ChangeNotifier {
  final DrawerLocalDataSource _dataSource = DrawerLocalDataSource();

  late List<DrawerItem> _items = _dataSource.getDrawerItems();
  List<DrawerItem> get items => _items;

  late DrawerItem _selectedItem = _items.first;
  DrawerItem? get selectedItem => _selectedItem;

  void selectItem(DrawerItem item) {
    _selectedItem = item;
    notifyListeners();
  }
}
