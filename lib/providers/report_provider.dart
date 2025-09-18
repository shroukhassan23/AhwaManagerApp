import 'package:ahwa_manager_app/services/order_service.dart';
import 'package:flutter/material.dart';

class ReportProvider extends ChangeNotifier {
  final IReportService _reportService; //DI

  ReportProvider(this._reportService);
  Map<String, int> get topSellingDrinks => _reportService.getTopSellingDrinks();
  List<MapEntry<String, int>> get topSellingDrinksSorted =>
      _reportService.getTopSellingDrinksSorted();
  String? get mostPopularDrink => _reportService.getMostPopularDrink();
  void refreshReports() {
    notifyListeners();
  }
}
