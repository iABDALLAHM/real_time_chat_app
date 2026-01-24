import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver implements BlocObserver {
 @override
  void onCreate(BlocBase bloc) {
    log(
      '🟢 onCreate — ${bloc.runtimeType}',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log(
      '📥 onEvent — ${bloc.runtimeType}, event: $event',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log(
      '🔄 onChange — ${bloc.runtimeType}, change: $change',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log(
      '🚀 onTransition — ${bloc.runtimeType}, transition: $transition',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log(
      '❌ onError — ${bloc.runtimeType}, error: $error',
    );
  }

  @override
  void onClose(BlocBase bloc) {
    log(
      '🔴 onClose — ${bloc.runtimeType}',
    );
  }
  
  @override
  void onDone(Bloc<dynamic, dynamic> bloc, Object? event, [Object? error, StackTrace? stackTrace]) {
    
  }
}