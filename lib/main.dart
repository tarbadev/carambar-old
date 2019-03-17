import 'package:carambar/application/ui/application_injector.dart';
import 'package:carambar/application/ui/carambar_app.dart';
import 'package:flutter/material.dart';

void main() {
  getApplicationInjector().configure();

  runApp(CarambarApp());
}


