🧪 Code Test - Flutter CRUD App with MVVM, BLoC
This Flutter application is built as part of a code test to demonstrate integration with an external RESTful API (crudcrud.com) using MVVM (Model-View-ViewModel) architecture , clean code principles, and separation of concerns.

📝 Objective
Build a simple Flutter app that consumes the crudcrud.com API to perform CRUD operations on a resource (e.g., Users or Unicorns), following MVVM Clean Architecture principles.

🔧 Features Implemented
✅ Integration with https://crudcrud.com/api/ for backend data persistence.
✅ MVVM Architecture:
Model : Data models and network layer handling.
View : Stateless UI widgets consuming state from ViewModels.
ViewModel : Business logic and interaction with repository.
✅ Repository Pattern for abstraction between data sources and business logic.
✅ Error handling and loading states.
✅ Proper folder structure reflecting clean architecture.

📦 Tech Stack
Flutter SDK : Dart & Widgets
HTTP Client : http package for REST API calls
State Management : ViewModel/Observable via provider or riverpod (optional)
External API : https://crudcrud.com
