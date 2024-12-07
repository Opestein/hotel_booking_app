enum HttpRequestType { post, get, put, patch, delete, head, request, download }

enum Env { dev, staging, live }

enum CustomImageWidgetType { any, file, asset, url, base64 }

enum BottomNavItem {
  home(widgetListIndex: 0, bottomNavIndex: 0),
  hotel(widgetListIndex: 1, bottomNavIndex: 1),
  favorites(widgetListIndex: 2, bottomNavIndex: 2),
  account(widgetListIndex: 3, bottomNavIndex: 3);

  final int widgetListIndex;
  final int bottomNavIndex;

  const BottomNavItem(
      {this.widgetListIndex = -100, this.bottomNavIndex = -100});
}
