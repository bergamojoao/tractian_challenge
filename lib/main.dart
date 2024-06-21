import 'package:flutter/material.dart';

import 'src/app_widget.dart';
import 'src/config/injector.dart';

void main() {
  registerInstances();
  runApp(AppWidget());
}
