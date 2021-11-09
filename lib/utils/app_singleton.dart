
import 'dart:ui';

class AppSingleton {
  static late final AppSingleton _singleton;
  static bool _isInstanceCreated = false;
  static Brightness brightness = Brightness.light;
  factory AppSingleton(){
    if (_isInstanceCreated = false){
      _singleton = AppSingleton();
    }
    _isInstanceCreated = true;
    return _singleton;
  }
}
// static late final _singleton = null;


// static late final GeustUser _instance;
// static bool _isInstanceCreated = false;
//
// factory GuestUser(
//     {required String firstName,
//       required String lastName,
//       required String email,
//       required Address address,
//       required PaymentInfo paymentInfo}) {
//   if (_isInstanceCreated == false) {
//     _instance =
//         GuestUser._(firstName, lastName, email, address, paymentInfo);
//   }
//   _isInsanceCreated = true;
//   return _instance;
// }