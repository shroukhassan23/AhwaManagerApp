// interface segregation
import 'package:ahwa_manager_app/models/drink_model.dart';
import 'package:ahwa_manager_app/models/order_model.dart';

abstract class IOrderWriter {
  void addOrder(Order customerOrder);
  void completeOrder(int orderId);
}

abstract class IOrderReader {
  List<Order> getPendingOrders();
  List<Order> getAllOrders();
}

abstract class IOrderReports {
  List<Order> getTotalOrdersServed();
  int getOrdersCount();
}

class ReportService implements IReportService {
  final IOrderReports orderReports; // Dependency Injection

  ReportService(this.orderReports);

  @override
  Map<String, int> getTopSellingDrinks() {
    List<Order> completedOrders = orderReports.getTotalOrdersServed();

    Map<String, int> drinkCount = {};

    for (Order order in completedOrders) {
      for (Drink drink in order.drink) {
        drinkCount[drink.drinkName] =
            (drinkCount[drink.drinkName] ?? 0) + drink.quantity;
      }
    }

    return drinkCount;
  }

  @override
  List<MapEntry<String, int>> getTopSellingDrinksSorted() {
    Map<String, int> drinkCount = getTopSellingDrinks();
    return drinkCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
  }

  @override
  String? getMostPopularDrink() {
    var sorted = getTopSellingDrinksSorted();
    return sorted.isNotEmpty ? sorted.first.key : null;
  }
}

abstract class IReportService {
  Map<String, int> getTopSellingDrinks();
  List<MapEntry<String, int>> getTopSellingDrinksSorted();
  String? getMostPopularDrink();
}

class OrderService implements IOrderWriter, IOrderReader, IOrderReports {
  final List<Order> _orders;

  OrderService(this._orders);

  @override
  void addOrder(Order customerOrder) {
    _orders.add(customerOrder);
  }

  @override
  void completeOrder(int orderId) {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      _orders[orderIndex].orderStatus = OrderStatus.completed;
    }
  }

  // من IOrderReader
  @override
  List<Order> getPendingOrders() {
    return _orders
        .where((order) => order.orderStatus == OrderStatus.pending)
        .toList();
  }

  @override
  List<Order> getAllOrders() => List.from(_orders);

  // من IOrderReports
  @override
  List<Order> getTotalOrdersServed() {
    return _orders
        .where((order) => order.orderStatus == OrderStatus.completed)
        .toList();
  }

  @override
  int getOrdersCount() => _orders.length;
}
