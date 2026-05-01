class DrawerItem {
  final String title;
  final List<DrawerItem>? subItems;

  DrawerItem({required this.title, this.subItems});
  bool get hasChildren => subItems != null && subItems!.isNotEmpty;
}
