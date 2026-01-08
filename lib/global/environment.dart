import 'dart:io';

class Environment {

  //emulador
  //static String apiUrl =    Platform.isAndroid ? 'http://10.0.2.2:3000/api' : 'http://localhost:3000/api';
  //static String socketUrl = Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
  
  //movil con cable
  //static String apiUrl =    Platform.isAndroid ? 'http://192.168.100.46:3000/api' : 'http://localhost:3000/api';
  //static String socketUrl = Platform.isAndroid ? 'http://192.168.100.46:3000' : 'http://localhost:3000';

  //movil con wifi
  static String ipAddress = '192.168.100.67';
  static String apiUrl =    'http://$ipAddress:3000/api';
  static String socketUrl = 'http://$ipAddress:3000';

}

