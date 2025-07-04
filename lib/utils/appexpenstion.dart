// ignore_for_file: non_constant_identifier_names

class AppException implements Exception{
  final String ?message;
  final String?prefix;
  final String ?Url;
  AppException([this.message,this.prefix,this.Url]);
}
class BadRequestException extends AppException{
  BadRequestException([String?message,String ?Url]):super(message,"Bad Request",Url);
}
class FetchDataException extends AppException {
  FetchDataException([String? message, String? url]) : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url]) : super(message, 'Api not responded in time', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url]) : super(message, 'UnAuthorized request', url);
}