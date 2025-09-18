import 'package:ahwa_manager_app/presentation/home_screen.dart';
import 'package:ahwa_manager_app/providers/order_provider.dart';
import 'package:ahwa_manager_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderProvider(OrderService([])),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ahwa Manager',
        home: HomeScreen(completed: false),
      ),
    );
  }
}
