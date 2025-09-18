import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier implements IOrderReports {
  final OrderService _orderService;

  OrderProvider(this._orderService);

  List<Order> get pendingOrders => _orderService.getPendingOrders();

  void addOrder(Order order) {
    _orderService.addOrder(order);
    notifyListeners();
  }

  // Method لإكمال order
  void completeOrder(int orderId) {
    _orderService.completeOrder(orderId);
    notifyListeners();
  }

  List<Order> get completedOrders => _orderService.getTotalOrdersServed();
  @override
  List<Order> getTotalOrdersServed() {
    return _orderService
        .getAllOrders()
        .where((order) => order.orderStatus == OrderStatus.completed)
        .toList();
  }

  @override
  int getOrdersCount() {
    return _orderService.getAllOrders().length;
  }
}
