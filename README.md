# iOS assignment | TestFlickr

### **High-level review of the application**
- Created file structure as per features and includes files(view, viewmodel, subviews..) into one group
- Used MVVM architecture with SOLID principles
- Made project unit testable using dependency injection whereever applicable.
- Improved test coverage for the all viewmodels
- Used composable views to build nested screens
- I would recommond usage of SPM for third party libraries.
- Image loading asynchronously
- I would recommond the modular structure based on feature.
- I would recommond Use Liniting tools eg. SwiftLint

### **Things that can be improved**
- Support of accessibility
- Introduce XCUItest
- Modularization
- Dark theme support
- dynamic fonts
- Indroduce loading indicator
- Introduce internet connectivity and failure and retry screens
- Introduce async/await for better performance and clean architecture. 

##### **Notes: The project works with Xcode 14.0 and above iOS 15 (Not sure about lower version might some apple api won't work) and the language used is Swift. And Run project into simulator land you to insert user location manually.**
