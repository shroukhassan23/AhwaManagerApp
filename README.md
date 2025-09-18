# Ahwa Manager App

A professional Flutter application designed for managing coffee shop (Ahwa) operations in Egypt. This app streamlines order management, tracks popular items, and generates comprehensive sales reports to help business owners optimize their operations.
<img width="538" height="1053" alt="image" src="https://github.com/user-attachments/assets/73cb2260-f1a8-48c9-834c-9a9d32e4acca" />
![WhatsApp Image 2025-09-18 at 21 39 37_9ae769d9](https://github.com/user-attachments/assets/666e4560-fc53-475d-8838-f388ba3a6de4)
![WhatsApp Image 2025-09-18 at 21 39 37_2b24788e](https://github.com/user-attachments/assets/1557840b-e89e-4b6d-b128-a5acfa7f6cfd)
![WhatsApp Image 2025-09-18 at 21 45 00_caca4851](https://github.com/user-attachments/assets/f78b9c44-179e-43ce-94f3-614c3788e408)


## Features

### Core Functionality
- **Order Management**: Add new orders with customer information and drink selections
- **Order Tracking**: View and manage pending orders with real-time status updates
- **Order Completion**: Mark orders as completed with visual confirmation
- **Sales Analytics**: Generate detailed reports on top-selling drinks and revenue
- **Multilingual Support**: Arabic and English interface elements

### Drink Menu
- **Tea Options**: Shai, Mint Tea, Hibiscus Tea
- **Coffee Options**: Turkish Coffee, American Coffee, Espresso
- **Customization**: Special instructions support (e.g., "extra mint, ya rais")
- **Flexible Quantities**: Support for multiple quantities per order

## Project Structure

### Architecture Pattern
The application follows **SOLID principles** and **Object-Oriented Programming** best practices:

```
lib/
├── models/                 # Data models
│   ├── customer_model.dart
│   ├── drink_model.dart
│   └── order_model.dart
├── services/              # Business logic layer
│   ├── order_service.dart
│   └── report_service.dart
├── providers/             # State management
│   ├── order_provider.dart
│   └── report_provider.dart
├── presentation/          # UI layer
│   ├── home_screen.dart
│   ├── add_order_screen.dart
│   ├── completed_order_screen.dart
│   └── reports_screen.dart
└── main.dart             # Application entry point
```

### Design Patterns Implemented

#### 1. **Single Responsibility Principle (SRP)**
- Each class has one specific responsibility
- Models only handle data representation
- Services handle business logic
- Providers manage state

#### 2. **Open/Closed Principle (OCP)**
- Services use interfaces for extensibility
- Easy to add new drink types or order operations

#### 3. **Interface Segregation Principle (ISP)**
- Separate interfaces for different operations:
  - `IOrderWriter` for order modifications
  - `IOrderReader` for order queries
  - `IReportService` for analytics

#### 4. **Dependency Inversion Principle (DIP)**
- High-level modules don't depend on low-level modules
- Both depend on abstractions (interfaces)

### Key Components

#### Models
```dart
// Core data structures
abstract class Drink          // Base drink class
class Tea extends Drink       // Tea-specific implementation
class Coffee extends Drink    // Coffee-specific implementation
class Order                   // Order data structure
class Customer               // Customer information
```

#### Services
```dart
// Business logic interfaces
abstract class IOrderWriter
abstract class IOrderReader
abstract class IReportService

// Implementations
class OrderService implements IOrderWriter, IOrderReader
class ReportService implements IReportService
```

#### State Management
Uses **Provider** pattern for reactive state management:
- `OrderProvider`: Manages order state and operations
- `ReportProvider`: Handles analytics and reporting

## Screenshots & UI Features

### Home Screen
- Real-time order statistics
- Pending orders list with customer details
- Quick action buttons for navigation
- Professional Egyptian coffee shop theme

### Add Order Screen
- Step-by-step order creation form
- Drink selection with prices and icons
- Quantity selector with visual feedback
- Special instructions field
- Real-time total calculation

### Completed Orders Screen

- Detailed breakdown of each order


### Sales Reports Screen
- Top-selling drinks ranking





## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or VS Code
- Android/iOS emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/ahwa_manager_app.git
   cd ahwa_manager_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  # Add other dependencies as needed
```

## Usage

1. **Adding Orders**: Tap "Add New Order" → Fill customer details → Select drinks → Set quantity → Add special instructions
2. **Managing Orders**: View pending orders on home screen → Tap checkbox to complete orders
3. **Viewing History**: Navigate to "Completed Orders" to see order history
4. **Analytics**: Check "Sales Reports" for business insights and top-selling items

## Business Logic

The application implements several key business processes:

- **Order Lifecycle**: Pending → Completed
- **Inventory Tracking**: Automatic calculation of quantities sold
- **Revenue Calculation**: Real-time total calculations
- **Popular Items Analysis**: Ranking system based on sales volume



## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Architecture Benefits

This implementation demonstrates:
- **Maintainable Code**: Clear separation of concerns
- **Testable Design**: Interfaces enable easy unit testing
- **Scalable Architecture**: Easy to extend with new features
- **Professional Standards**: Industry best practices applied

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Contact

For questions or suggestions, please open an issue or contact the development team.

---
Built with ❤️ for Egyptian coffee shop owners 
