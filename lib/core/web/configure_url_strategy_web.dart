import 'package:flutter_web_plugins/url_strategy.dart';

/// Path URLs (`/pricing`) instead of hashes (`/#/pricing`) so crawlers can index routes.
void configureUrlStrategy() {
  usePathUrlStrategy();
}
