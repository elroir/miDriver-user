class FormValidators{


  static bool isValidEmail (String s) {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(s);
  }

  static String? validateEmail(String? value) {
    if(!isValidEmail(value!)) return 'Ingrese un correo valido';
    return null;
  }

  static String? validateEqual(String text,String other,{String message = 'Las contraseñas no coinciden'}) {

    if (text != other) {
      return message;
    }
    return null;
  }


  static String? validateNotShorter(String? text,{int length = 3}) {
    if (text!.isEmpty) {
      return 'campo obligatorio';
    }

    if (text.length < length) {
      return 'Muy corto';
    }

    return null;
  }


  static String? validatePhoneNumber(String? text){
    if(_isNumeric(text!)){
      return null;
    }
    if(text.isEmpty){
      return 'Campo obligatorio';
    }

    if(text.length<7){
      return 'Número muy corto';
    }

    return 'Número invalido';

  }

  static String? validateInt(String? text,{int? greaterThan,int? lowerThan}){
    if(_isInt(text!)){

      if(greaterThan!=null){
        final number = int.parse(text);
        if(number<greaterThan){
          return 'Elija un número mayor';
        }

      }


      if(lowerThan!=null){
        final number = int.parse(text);
        if(number>lowerThan){
          return 'Elija un número menor';
        }

      }

      return null;
    }
    if(text.isEmpty){
      return 'Campo obligatorio';
    }

    return 'Número invalido';

  }

  static bool _isInt (String s) {
    if (s.isEmpty) return false ;

    final n = int.tryParse(s);

    return (n == null) ? false : true;

  }

  static bool _isNumeric (String s) {
    if (s.isEmpty) return false ;

    final n = num.tryParse(s);

    return (n == null) ? false : true;

  }

}