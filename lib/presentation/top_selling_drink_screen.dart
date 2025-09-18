// screens/reports_screen.dart
import 'package:ahwa_manager_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

import '../providers/report_provider.dart';

class ReportsScreen extends StatelessWidget {
  final OrderProvider orderProvider;

  const ReportsScreen({required this.orderProvider});

  @override
  Widget build(BuildContext context) {
    final reportService = ReportService(orderProvider);

    return ChangeNotifierProvider(
      create: (_) => ReportProvider(reportService),
      child: Scaffold(
        appBar: AppBar(
          title: Text('📊 Sales Reports'),
          backgroundColor: Colors.purple[300],
        ),
        body: Consumer<ReportProvider>(
          builder: (context, reportProvider, child) {
            var topDrinks = reportProvider.topSellingDrinksSorted;

            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Most Popular Drink Card
                  Card(
                    color: Colors.green[100],
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(
                            Icons.emoji_events,
                            size: 48,
                            color: Colors.amber,
                          ),
                          Text(
                            '🏆 Most Popular Drink',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            reportProvider.mostPopularDrink ?? 'No data yet',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.green[800],
                            ),
                          ),
                          if (topDrinks.isNotEmpty)
                            Text('${topDrinks.first.value} units sold'),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    '🥇 Top Selling Drinks Ranking:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  // Top Drinks List
                  Expanded(
                    child: topDrinks.isEmpty
                        ? Center(child: Text('No sales data available'))
                        : ListView.builder(
                            itemCount: topDrinks.length,
                            itemBuilder: (context, index) {
                              var drink = topDrinks[index];
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                    backgroundColor: _getRankColor(index),
                                  ),
                                  title: Text(drink.key),
                                  trailing: Text(
                                    '${drink.value} units',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getRankColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber; // Gold
      case 1:
        return Colors.grey; // Silver
      case 2:
        return Colors.brown; // Bronze
      default:
        return Colors.blue;
    }
  }
}
