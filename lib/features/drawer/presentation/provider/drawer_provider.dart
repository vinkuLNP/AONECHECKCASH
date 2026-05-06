import 'package:a1_check_cashers/features/drawer/data/data_sources/drawer_local_data.dart';
import 'package:a1_check_cashers/features/drawer/domain/entities/drawer_entity.dart';
import 'package:flutter/material.dart';

class DrawerProvider extends ChangeNotifier {
  final DrawerLocalDataSource _dataSource = DrawerLocalDataSource();

  late final List<DrawerItem> _items = _dataSource.getDrawerItems();
  List<DrawerItem> get items => _items;

  late DrawerItem _selectedItem = _items.first;
  DrawerItem? get selectedItem => _selectedItem;
  final Set<DrawerItem> _expandedItems = {};

  bool isExpanded(DrawerItem item) => _expandedItems.contains(item);

  void toggleExpand(DrawerItem item) {
    if (_expandedItems.contains(item)) {
      _expandedItems.remove(item);
    } else {
      _expandedItems.add(item);
    }
    notifyListeners();
  }

  void selectItem(DrawerItem item) {
    _selectedItem = item;
    notifyListeners();
  }
}
