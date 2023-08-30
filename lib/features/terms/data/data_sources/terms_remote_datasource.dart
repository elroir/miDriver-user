import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/http/http_options.dart';
import '../models/term_model.dart';

abstract interface class TermsRemoteDataSource{
  ///Calls [HttpOptions.apiUrl]/users/me to get user data
  ///returns [TermModel] object
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<TermModel> getTermsAndConditions();
}

class TermsRemoteDataSourceImpl implements TermsRemoteDataSource {

  final Client _client;

  TermsRemoteDataSourceImpl(this._client);

  @override
  Future<TermModel> getTermsAndConditions() async {
    final url = Uri.https(HttpOptions.apiUrl,'items/terms');

    final response = await _client.get(url,headers: {
      'Authorization': HttpOptions.apiToken,
      'Content-Type' : 'application/json'
    },);

    if(response.statusCode!=200){
      throw ServerException();
    }

    final data = json.decode(response.body);

    return TermModel.fromJson(data['data']);
  }

}