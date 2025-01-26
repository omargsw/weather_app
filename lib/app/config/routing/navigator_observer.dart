import 'dart:developer';

import 'package:flutter/material.dart';

class MyObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('New route pushed --> ${route.settings.name}', name: "Navigator");
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log('Route popped --> ${route.settings.name}', name: "Navigator");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log('Route replaced --> ${newRoute?.settings.name}', name: "Navigator");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    log('Route removed --> ${route.settings.name}', name: "Navigator");
  }
}
