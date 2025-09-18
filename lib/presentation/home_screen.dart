import 'package:ahwa_manager_app/models/order_model.dart';
import 'package:ahwa_manager_app/presentation/top_selling_drink_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ahwa_manager_app/presentation/add_order_screen.dart';
import 'package:ahwa_manager_app/presentation/completed_order_screen.dart';
import 'package:ahwa_manager_app/providers/order_provider.dart';
import 'package:ahwa_manager_app/services/order_service.dart';

class HomeScreen extends StatefulWidget {
  bool? completed;
  HomeScreen({super.key, required this.completed});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ahwa Manager',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.brown[700],
        elevation: 4,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {}); // Refresh the screen
            },
          ),
        ],
      ),
      backgroundColor: Colors.brown[50],
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.brown[100]!, Colors.brown[50]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Consumer<OrderProvider>(
              builder: (context, orderProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                      'Pending Orders',
                      '${orderProvider.pendingOrders.length}',
                      Icons.pending_actions,
                      Colors.orange,
                    ),
                    _buildStatCard(
                      'Completed Orders',
                      '${orderProvider.completedOrders.length}',
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ],
                );
              },
            ),
          ),

          // Pending Orders List
          Expanded(
            child: Consumer<OrderProvider>(
              builder: (context, orderProvider, child) {
                if (orderProvider.pendingOrders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.coffee_outlined,
                          size: 80,
                          color: Colors.brown[300],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No pending orders',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.brown[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add a new order to get started',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.brown[400],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: orderProvider.pendingOrders.length,
                  itemBuilder: (context, index) {
                    final order = orderProvider.pendingOrders[index];
                    final orderTotal = _calculateOrderTotal(order);

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [Colors.pink[100]!, Colors.pink[50]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown[600],
                            radius: 25,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      order.customer.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.brown[800],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.orange[300]!,
                                      ),
                                    ),
                                    child: Text(
                                      'PENDING',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              ...order.drink
                                  .map((drink) => _buildDrinkRow(drink))
                                  .toList(),
                              Divider(color: Colors.brown[300]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.brown[700],
                                    ),
                                  ),
                                  Text(
                                    '${orderTotal.toStringAsFixed(2)} EGP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Checkbox(
                              value: order.orderStatus == OrderStatus.completed,
                              activeColor: Colors.green[600],
                              onChanged: (bool? newValue) {
                                if (newValue == true) {
                                  orderProvider.completeOrder(order.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Order completed!'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Action Buttons
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ChangeNotifierProvider.value(
                                  value: context.read<OrderProvider>(),
                                  child: AddOrderScreen(),
                                );
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text(
                          'Add New Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[600],
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return CompletedOrderScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.check_circle, color: Colors.white),
                        label: Text(
                          'Completed Orders',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final orderProvider = context.read<OrderProvider>();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ReportsScreen(orderProvider: orderProvider),
                            ),
                          );
                        },
                        icon: Icon(Icons.analytics, color: Colors.white),
                        label: Text(
                          'Sales Reports',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[600],
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 30),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDrinkRow(drink) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              drink.drinkName,
              style: TextStyle(
                fontSize: 14,
                color: Colors.brown[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'x${drink.quantity}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            '${(drink.quantity * drink.drinkPrice).toStringAsFixed(1)} EGP',
            style: TextStyle(
              fontSize: 14,
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  double _calculateOrderTotal(Order order) {
    return order.drink.fold<double>(
      0.0,
      (double total, drink) => total + (drink.quantity * drink.drinkPrice),
    );
  }
}
