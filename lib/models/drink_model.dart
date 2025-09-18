//OCP
abstract class Drink {
  String drinkName;
  double drinkPrice;
  String? specialInstructions;
  int quantity;
  Drink({
    required this.drinkName,
    required this.drinkPrice,
    this.specialInstructions,
    required this.quantity,
  });
}

class Tea extends Drink {
  TeaType teaType;
  Tea({
    required this.teaType,
    super.specialInstructions,
    required super.drinkName,
    required super.drinkPrice,
    required super.quantity,
  });
}

class Coffee extends Drink {
  CoffeeType coffeeType;
  Coffee({
    required this.coffeeType,
    required super.drinkName,
    required super.drinkPrice,
    super.specialInstructions,
    required super.quantity,
  });
}

enum TeaType { shai, mint, hibiscus }

enum CoffeeType { turkish, american, espresso }
