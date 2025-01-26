import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_logger.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      AppLogger.debug('onEvent -- Bloc: ${bloc.runtimeType} --> event: $event');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      AppLogger.debug('onTransition -- Bloc: ${bloc.runtimeType} --> transition: $transition');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      AppLogger.debug('onChange -- Bloc: ${bloc.runtimeType} --> change: $change');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      AppLogger.error('onError -- Bloc: ${bloc.runtimeType} --> error: $error, stackTrace: $stackTrace');
    }
  }
}
