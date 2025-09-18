import 'package:ahwa_manager_app/models/drink_model.dart';
import 'package:ahwa_manager_app/models/order_model.dart';
import 'package:ahwa_manager_app/providers/order_provider.dart';
import 'package:ahwa_manager_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedOrderScreen extends StatelessWidget {
  const CompletedOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Orders'),
        backgroundColor: Colors.green[300],
        elevation: 2,
      ),
      backgroundColor: Colors.grey[50],
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          final completedOrders = orderProvider.completedOrders;

          if (completedOrders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No completed orders yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Completed orders will appear here',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Header with count
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  border: Border(
                    bottom: BorderSide(color: Colors.green[200]!, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green[700]),
                    SizedBox(width: 8),
                    Text(
                      '${completedOrders.length} Completed Orders',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ],
                ),
              ),

              // Orders List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: completedOrders.length,
                  itemBuilder: (context, index) {
                    final order = completedOrders[index];
                    final totalOrderPrice = _calculateOrderTotal(order);

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.green[200]!,
                            width: 1,
                          ),
                        ),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green[100],
                            child: Icon(
                              Icons.person,
                              color: Colors.green[700],
                              size: 20,
                            ),
                          ),
                          title: Text(
                            order.customer.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${totalOrderPrice.toStringAsFixed(2)} EGP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green[800],
                                ),
                              ),
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Details:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ...order.drink
                                      .map((drink) => _buildDrinkItem(drink))
                                      .toList(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrinkItem(Drink drink) {
    final itemTotal = drink.quantity * drink.drinkPrice;

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  drink.drinkName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Text(
                '${itemTotal.toStringAsFixed(2)} EGP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Qty: ${drink.quantity}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${drink.drinkPrice} EGP each',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (drink.specialInstructions != null &&
              drink.specialInstructions!.isNotEmpty) ...[
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.note_alt, size: 14, color: Colors.amber[700]),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      drink.specialInstructions!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.amber[800],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
