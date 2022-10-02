class Validator{

  static final Validator _instance = Validator._internal();

  factory Validator() {
    return _instance;
  }

  Validator._internal();

  /*r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
  *
  * r'([a-z0-9][-a-z0-9_+.][a-z0-9])@([a-z0-9][-a-z0-9.][a-z0-9].(com|net)|([0-9]{1,3}.{3}[0-9]{1,3}))'*/
   bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return (regex.hasMatch(value)) ? true : false;
  }

  bool validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern.toString());
    return (regex.hasMatch(value)) ? true : false;
  }

  /*r'^
  (?=.*[A-Z])       // should contain at least one upper case
  (?=.*[a-z])       // should contain at least one lower case
  (?=.*?[0-9])          // should contain at least one digit
 (?=.*?[!@#\$&*~]).{8,}  // should contain at least one Special character
$*/


  /// check if the string contains only numbers
  RegExp _numeric = RegExp(r'^-?[0-9]+$');
  bool isNumeric(String str) {
    return _numeric.hasMatch(str);
  }
}