import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ft_flutter_riverpod/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FlutterRiverPodApp(),
    ),
  );
}
