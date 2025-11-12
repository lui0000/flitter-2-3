import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'core/service_locator.dart';
import 'app.dart';
import 'observer/counter_observer.dart';

void main() {
  Bloc.observer = CounterObserver();
  setupServiceLocator();
  runApp(const App());
}
