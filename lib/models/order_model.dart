// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ahwa_manager_app/models/customer_model.dart';
import 'package:ahwa_manager_app/models/drink_model.dart';

class Order {
  int id;
  Customer customer;
  OrderStatus orderStatus = OrderStatus.pending;
  List<Drink> drink;
  Order({required this.id, required this.customer, required this.drink});
}

enum OrderStatus { pending, completed, cancelled }
