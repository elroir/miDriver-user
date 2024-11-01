import 'package:http/http.dart';

class HttpOptions{

  HttpOptions._();

  static const _devUrl = 'admin.midriverdesignado.com';

  static const apiToken = 'Bearer ZqO5ANCprCQ9T5vR30rnfhhFrVAO9oF1';

  static const oneSignalKey = 'd10eb845-9354-421c-b259-176080047de1';

  static const userRoleId = 'cbb77f30-c827-4f47-969c-8452052552c9';

  static const socketUrl = 'wss://midriver.elroir.cloud/websocket';

  static const privacyPolicyUrl  =  'https://legal.midriverdesignado.com/privacy-policy';

  static const mapBoxToken  =  'pk.eyJ1IjoiZWxyb2lyIiwiYSI6ImNsdXd6dnloeDBqMTEya21reDFhMDFjc2EifQ.FgK_drfNT6HcMn6kU2Gjdw';


  static const imageHeaders  =  {'Authorization' : apiToken};


  static const apiUrl = _devUrl;

  static Client get client => Client();

}