import 'package:ahwa_manager_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../models/order_model.dart';
import '../models/customer_model.dart';
import '../models/drink_model.dart';

class AddOrderScreen extends StatefulWidget {
  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _specialInstructionsController = TextEditingController();

  String? selectedDrinkType;
  int quantity = 1;

  final Map<String, Map<String, dynamic>> drinkPrices = {
    'shai': {'name': 'Shai', 'price': 5.0, 'icon': '🫖'},
    'mint_tea': {'name': 'Mint Tea', 'price': 7.0, 'icon': '🌿'},
    'hibiscus': {'name': 'Hibiscus Tea', 'price': 8.0, 'icon': '🌺'},
    'turkish_coffee': {'name': 'Turkish Coffee', 'price': 15.0, 'icon': '☕'},
    'american_coffee': {'name': 'American Coffee', 'price': 12.0, 'icon': '☕'},
    'espresso': {'name': 'Espresso', 'price': 20.0, 'icon': '☕'},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Order',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[700],
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.brown[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        size: 50,
                        color: Colors.brown[600],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Create New Order',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                      Text(
                        'Fill in the details below',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Customer Name Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.brown[600]),
                          SizedBox(width: 8),
                          Text(
                            'Customer Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _customerNameController,
                        decoration: InputDecoration(
                          labelText: 'Customer Name',
                          hintText: 'Enter customer name',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true)
                            return 'Please enter customer name';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Drink Selection Card
              Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_cafe, color: Colors.brown[600]),
                          SizedBox(width: 8),
                          Text(
                            'Drink Selection',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: selectedDrinkType,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: 'Choose Drink',

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        items: drinkPrices.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  entry.value['icon'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: 10),
                                Flexible(child: Text(entry.value['name'])),
                                SizedBox(width: 10),
                                Text(
                                  '${entry.value['price']} EGP',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDrinkType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) return 'Please select a drink';
                          return null;
                        },
                      ),

                      if (selectedDrinkType != null) ...[
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.green[700],
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Selected: ${drinkPrices[selectedDrinkType]!['name']} - ',
                                style: TextStyle(color: Colors.green[700]),
                              ),
                              Text(
                                '${drinkPrices[selectedDrinkType]!['price']} EGP each',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Quantity Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.format_list_numbered,
                            color: Colors.brown[600],
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: quantity > 1
                                  ? Colors.red[100]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: IconButton(
                              onPressed: quantity > 1
                                  ? () => setState(() => quantity--)
                                  : null,
                              icon: Icon(
                                Icons.remove,
                                color: quantity > 1
                                    ? Colors.red[700]
                                    : Colors.grey[500],
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.brown[100],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.brown[300]!),
                            ),
                            child: Text(
                              '$quantity',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[800],
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: IconButton(
                              onPressed: () => setState(() => quantity++),
                              icon: Icon(Icons.add, color: Colors.green[700]),
                            ),
                          ),
                        ],
                      ),
                      if (selectedDrinkType != null) ...[
                        SizedBox(height: 12),
                        Center(
                          child: Text(
                            'Total: ${(quantity * drinkPrices[selectedDrinkType]!['price']).toStringAsFixed(2)} EGP',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Special Instructions Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.note_add, color: Colors.brown[600]),
                          SizedBox(width: 8),
                          Text(
                            'Special Instructions (Optional)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _specialInstructionsController,
                        decoration: InputDecoration(
                          labelText: 'Special Instructions',
                          hintText: 'e.g., extra mint, ya rais, no sugar',
                          prefixIcon: Icon(Icons.edit_note),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),

              // Add Order Button
              Container(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _addOrder,
                  icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                  label: Text(
                    'Add Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _addOrder() {
    if (_formKey.currentState?.validate() ?? false) {
      final customer = Customer(name: _customerNameController.text);

      Drink drink;
      switch (selectedDrinkType) {
        case 'shai':
          drink = Tea(
            teaType: TeaType.shai,
            drinkName: 'Shai',
            drinkPrice: 5.0,
            quantity: quantity,
            specialInstructions: _specialInstructionsController.text.isEmpty
                ? null
                : _specialInstructionsController.text,
          );
          break;
        case 'mint_tea':
          drink = Tea(
            teaType: TeaType.mint,
            drinkName: 'Mint Tea',
            drinkPrice: 7.0,
            quantity: quantity,
            specialInstructions: _specialInstructionsController.text.isEmpty
                ? null
                : _specialInstructionsController.text,
          );
          break;
        case 'hibiscus':
          drink = Tea(
            teaType: TeaType.hibiscus,
            drinkName: 'Hibiscus Tea',
            drinkPrice: 8.0,
            quantity: quantity,
            specialInstructions: _specialInstructionsController.text.isEmpty
                ? null
                : _specialInstructionsController.text,
          );
          break;
        case 'turkish_coffee':
          drink = Coffee(
            coffeeType: CoffeeType.turkish,
            drinkName: 'Turkish Coffee',
            drinkPrice: 15.0,
            quantity: quantity,
            specialInstructions: _specialInstructionsController.text.isEmpty
                ? null
                : _specialInstructionsController.text,
          );
          break;
        case 'american_coffee':
          drink = Coffee(
            coffeeType: CoffeeType.american,
            drinkName: 'American Coffee',
            drinkPrice: 12.0,
            quantity: quantity,
            specialInstructions: _specialInstructionsController.text.isEmpty
                ? null
                : _specialInstructionsController.text,
          );
          break;
        case 'espresso':
          drink = Coffee(
            coffeeType: CoffeeType.espresso,
            drinkName: 'Espresso',
            drinkPrice: 20.0,
            quantity: quantity,
            specialInstructions: _specialInstructionsController.text.isEmpty
                ? null
                : _specialInstructionsController.text,
          );
          break;
        default:
          return;
      }

      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch,
        customer: customer,
        drink: [drink],
      );

      Provider.of<OrderProvider>(context, listen: false).addOrder(order);

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Order added successfully!'),
            ],
          ),
          backgroundColor: Colors.green[600],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }
}
