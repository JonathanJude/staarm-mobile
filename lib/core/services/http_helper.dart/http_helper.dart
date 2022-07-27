import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../../app/storage_helper.dart';
import '../../../app/storage_keys.dart';
import '../../../utils/constants.dart';
import '../../../utils/error_helper.dart';
import '../../api/config.dart';
import '../../api/server_error.dart';
import '../../api/service_state.dart';
import '../../enums/server_error_types.dart';

/// Helper service that abstracts away common HTTP Requests
class HttpHelper {
  static Dio _client;
  final _log = Logger('HttpHelper');
  static final _config = Config();
  static String baseURL = _config.baseURL;

  static Future<Dio> _getInstance() async {
    final storageToken = await StorageHelper.getString(StorageKeys.token);

    if (_client == null) _client = Dio();

    Map<String, dynamic> headers = {};
    headers['Content-Type'] = 'application/json';
    if (storageToken != null) headers['Authorization'] = 'Bearer $storageToken';

    _client.options.headers = headers;
    _client.options.baseUrl = baseURL;
    _client.options.sendTimeout = CONNECT_TIMEOUT;
    _client.options.receiveTimeout = CONNECT_TIMEOUT;
    _client.options.connectTimeout = CONNECT_TIMEOUT;
    return _client;
  }

  @override
  Future<ServiceState> get(
    String route, {
    List<int> successStatusCodes = const [200, 201],
    ServiceState Function(dynamic data, int statusCode) onError,
    bool checkStatus = true,
  }) async {
    final instance = await _getInstance();
    String hed = instance.options.headers.toString();
    print("Dio instance headers $hed");

    Response response;

    _log.fine('Sending GET to $route');

    try {
      final fullRoute = '$route';
      response = await instance.get(fullRoute);
      print(response.toString());
    } on SocketException {
      return _internetError;
    } on FormatException {
      return _unknownError;
    } on DioError catch (dioError) {
      print(response.toString());
      return _getDioErrorState(dioError, onError: onError);
    } catch (e) {
      return _unknownError;
    }

    if (successStatusCodes.contains(response.statusCode) &&
        _responseStatusIsTrue(response.data, checkStatus)) {
      print(response);
      return ServiceState.success(response.data);
    }

    return onError != null
        ? onError(response.data, response.statusCode)
        : _dioError(
            response.data['message'],
            response.data,
            response.statusCode,
          );
  }

  @override
  Future<ServiceState> post(
    String route, {
    body,
    headers,
    List<int> successStatusCodes = const [200, 201],
    ServiceState Function(dynamic data, int statusCode) onError,
    bool checkStatus = true,
    bool useMultiPart = false,
  }) async {
    final instance = await _getInstance();
    String hed = instance.options.headers.toString();
    print("Dio instance headers $hed");

    Response response;

    if (useMultiPart) {
      instance.options.setRequestContentTypeWhenNoPayload = true;
      instance.options.contentType = 'multipart/form-data';
    }

    Options _options = Options(
      contentType: 'multipart/form-data',
    );

    _log.fine('Sending $body to $route');
    print('Sending $body to $route');

    try {
      final fullRoute = '$route';
      response = await instance.post(
        fullRoute,
        data: body,
        options: _options,
      );

      print(response);
      print("status code === ${response.statusCode}");
    } on SocketException {
      return _internetError;
    } on FormatException {
      return _unknownError;
    } on DioError catch (dioError) {
      return _getDioErrorState(dioError, onError: onError);
    } catch (e) {
      return _unknownError;
    }

    if (successStatusCodes.contains(response.statusCode) &&
        _responseStatusIsTrue(response.data, checkStatus)) {
      return ServiceState.success(response.data);
    }
    return onError != null
        ? onError(response.data, response.statusCode)
        : _dioError(
            response.data['message'],
            response.data,
            response.statusCode,
          );
  }

  @override
  Future<ServiceState> put(
    String route, {
    body,
    headers,
    List<int> successStatusCodes = const [200, 201],
    ServiceState Function(dynamic data, int statusCode) onError,
    bool checkStatus = true,
  }) async {
    final instance = await _getInstance();
    String hed = instance.options.headers.toString();
    print("Dio instance headers $hed");

    Response response;

    // sharedPreferences = await SharedPreferences.getInstance();
    // final _token = prefs.getString("loggedInToken") ?? '';

    // final _headers = new Map<String, String>();
    // _headers['Content-Type'] = 'application/json';
    // _headers['Authorization'] = 'Bearer $_token';

    // print('token -------- ${_keyStorageService.apiToken}');

    // final options = Options(headers: _headers, contentType: 'application/json');

    _log.fine('Sending $body to $route');

    try {
      final fullRoute = '$route';
      response = await instance.put(
        fullRoute,
        data: body,
        // options: options,
      );

      print("response is -- $response");
    } on SocketException {
      return _internetError;
    } on FormatException {
      return _unknownError;
    } on DioError catch (dioError) {
      return _getDioErrorState(dioError, onError: onError);
    } catch (e) {
      return _unknownError;
    }

    if (successStatusCodes.contains(response.statusCode) &&
        _responseStatusIsTrue(response.data, checkStatus)) {
      return ServiceState.success(response.data);
    }
    return onError != null
        ? onError(response.data, response.statusCode)
        : _dioError(
            response.data['message'],
            response.data,
            response.statusCode,
          );
  }

  //PATCH
  @override
  Future<ServiceState> patch(
    String route, {
    body,
    headers,
    List<int> successStatusCodes = const [200, 201],
    ServiceState Function(dynamic data, int statusCode) onError,
    bool checkStatus = true,
  }) async {
    final instance = await _getInstance();
    String hed = instance.options.headers.toString();
    print("Dio instance headers $hed");

    Response response;

    // sharedPreferences = await SharedPreferences.getInstance();
    // final _token = prefs.getString("loggedInToken") ?? '';

    // final _headers = new Map<String, String>();
    // _headers['Content-Type'] = 'application/json';
    // _headers['Authorization'] = 'Bearer $_token';

    // print('token -------- ${_keyStorageService.apiToken}');

    // final options = Options(headers: _headers, contentType: 'application/json');

    _log.fine('Sending $body to $route');

    try {
      final fullRoute = '$route';
      response = await instance.patch(
        fullRoute,
        data: body,
        // options: options,
      );
      print("response is -- $response");
    } on SocketException {
      return _internetError;
    } on FormatException {
      return _unknownError;
    } on DioError catch (dioError) {
      return _getDioErrorState(dioError, onError: onError);
    } catch (e) {
      return _unknownError;
    }

    if (successStatusCodes.contains(response.statusCode) &&
        _responseStatusIsTrue(response.data, checkStatus)) {
      return ServiceState.success(response.data);
    }
    return onError != null
        ? onError(response.data, response.statusCode)
        : _dioError(
            response.data['message'],
            response.data,
            response.statusCode,
          );
  }

  @override
  Future<ServiceState> delete(
    String route, {
    body,
    headers,
    List<int> successStatusCodes = const [200, 201],
    ServiceState Function(dynamic data, int statusCode) onError,
    bool checkStatus = true,
  }) async {
    final instance = await _getInstance();
    String hed = instance.options.headers.toString();
    print("Dio instance headers $hed");

    Response response;

    // sharedPreferences = await SharedPreferences.getInstance();
    // final _token = prefs.getString("loggedInToken") ?? '';

    // final _headers = new Map<String, String>();
    // _headers['Content-Type'] = 'application/json';
    // _headers['Authorization'] = 'Bearer $_token';

    // print('token -------- ${_keyStorageService.apiToken}');

    // final options = Options(headers: _headers, contentType: 'application/json');

    _log.fine('Sending $body to $route');

    try {
      final fullRoute = '$route';
      response = await instance.delete(
        fullRoute,
        data: body,
        // options: options,
      );
      print("response is -- $response");
    } on SocketException {
      return _internetError;
    } on FormatException {
      return _unknownError;
    } on DioError catch (dioError) {
      return _getDioErrorState(dioError, onError: onError);
    } catch (e) {
      return _unknownError;
    }

    if (successStatusCodes.contains(response.statusCode) &&
        _responseStatusIsTrue(response.data, checkStatus)) {
      return ServiceState.success(response.data);
    }
    return onError != null
        ? onError(response.data, response.statusCode)
        : _dioError(
            response.data['message'],
            response.data,
            response.statusCode,
          );
  }

  //Map `DioError` to `ServiceState`
  ServiceState _getDioErrorState(
    DioError dioError, {
    ServiceState Function(dynamic data, int statusCode) onError,
  }) {
    print(dioError.type);

    switch (dioError.type) {
      case DioErrorType.response:
        if (onError != null) {
          return onError(dioError.response.data, dioError.response.statusCode);
        } else {
          print(dioError.response.statusCode);

          print("DIO Error ---- ${dioError.response.data}");
          return _dioError(
            dioError.response.data['message'].toString(),
            dioError.response.data,
            dioError.response.statusCode,
          );
        }
        break;
      case DioErrorType.other:
      case DioErrorType.connectTimeout:
        return _requestTimeOutState;
        break;
      case DioErrorType.receiveTimeout:
        return _requestTimeOutState;
        break;
      case DioErrorType.sendTimeout:
        return _requestTimeOutState;
        break;
      default:
        return _unknownError;
        break;
    }
  }

  final ServiceState _requestTimeOutState =
      ServiceState<ServerErrorModel>.error(
    const ServerErrorModel(
      statusCode: 400,
      errorMessage: 'Request timeout. Please, try again',
      data: null,
      type: ServerErrorTypes.timeout,
    ),
  );

  final ServiceState _internetError = ServiceState<ServerErrorModel>.error(
    const ServerErrorModel(
      statusCode: 400,
      errorMessage:
          // ignore: lines_longer_than_80_chars
          'Something went wrong please check your internet connection and try again',
      data: null,
      type: ServerErrorTypes.internetConnection,
    ),
  );

  final ServiceState _unknownError = ServiceState<ServerErrorModel>.error(
    ServerErrorModel(
      statusCode: 500,
      errorMessage: genericErrorMessageString,
      data: null,
      type: ServerErrorTypes.unknown,
    ),
  );

  ServiceState _dioError(
    String message,
    dynamic data,
    int statusCode,
  ) {
    print("DIO ERROR Message: ---- $message");
    print("DIO ERROR StatusCode: ---- $statusCode");
    print("DIO ERROR data: ---- $data");
    String _errorMessage = genericErrorMessageString;

    if (data['status'] != null && data['status'] == false) {
      if (data['data'] != null && data['data'] is Map && data['data'] != {} && data['data'].isNotEmpty) {
        Map _dataMap = data['data'] as Map;

        if(_dataMap?.values?.first != null) {
          if(_dataMap?.values?.first is List) _errorMessage = _dataMap.values.first.first.toString(); 
          else _errorMessage = _dataMap.values.first.toString(); 
        }
      } else if (data['message'] != null && data['message'] is String) {
        _errorMessage = data['message'];
      } else if (data['data'] != null && data['data'] is String) {
        _errorMessage = data['data'];
      }

      return ServiceState.error(
        ServerErrorModel(statusCode: 400, errorMessage: _errorMessage),
      );
    }

    return ServiceState<ServerErrorModel>.error(
      ServerErrorModel(
        statusCode: statusCode,
        errorMessage: message ?? _errorMessage,
        data: data,
      ),
    );
  }

  bool _responseStatusIsTrue(dynamic data, bool checkStatus) {
    print("ressss -- $data");
    if (!checkStatus) return true;
    if (data['status'] == null) return false;

    if (data['status'] == true) return true;

    return false;
  }

  @override
  void dispose() async {
    final instance = await _getInstance();

    instance.clear();
    instance.close(force: true);
  }
}
