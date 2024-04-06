// ignore_for_file: depend_on_referenced_packages, file_names, constant_identifier_names, await_only_futures, avoid_print, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bank_bay/utils/appexpenstion.dart';
import 'package:http/http.dart' as http;


class BaseClient{
  static const int TIME_OUT_DURATION = 40;
  String? token;
  Future<dynamic> post(String url, dynamic body)async
  {
    print("API =========>>>>>>> $url");
    var uri=Uri.parse(url);
    var payload=body;
    try {
      var response=await http.post(uri,
          headers:   {
            "x-api-key":"api@parthshopping.com",
          },
          body: payload).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> get(String url, [Map<String, dynamic>? bodyRequest])async
  {
    print("API =========>>>>>>> $url");
    var uri=Uri.parse(url);
    try {
      var response=await http.get(uri,
        headers:   {
          'x-api-key':'api@parthshopping.com'
        },
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> getUrl(String url)async
  {
    print("API =========>>>>>>> $url");
    var uri=Uri.parse(url);
    try {
      var response=await http.get(uri,
        headers:   {
          'x-api-key':'api@parthshopping.com'
        },
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException('Error occurred with code : ${response.statusCode}', response.request!.url.toString());
    }
  }

  postMultiple(String postFeedBack, List<File> list, read, String catid, msg) {}


  Future<dynamic> imagePost(String url,var bodyreq)async
  {
    print("API =========>>>>>>> $url");
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
      // for (var file in path)
      // {
      // print("object ${file["attachment"].path.toString()}");
      // request.files.add(await http.MultipartFile.fromPath('attachment', file["attachment"].path.toString()));
      // }
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key':'api@parthshopping.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> selfieUpload(String url, path)async
  {
    print("API =========>>>>>>> $url");
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
      if(path.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('selfie',path));
      request.headers.addAll({'x-api-key':'api@parthshopping.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> empSelfieUpload(String url, path)async
  {
    print("API =========>>>>>>> $url");
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
      if(path.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('doc_profile_pic',path));
      request.headers.addAll({'x-api-key':'api@parthshopping.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> shopUpdate(String url,var bodyreq, path)async
  {
    print("API =========>>>>>>> $url");
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
      if(path.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('shop_photo',path));
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key':'api@parthshopping.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }


  Future<dynamic> underDeliverImage(var bodyreq, String url, path)async
  {
    print("API =========>>>>>>> $url");
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
      if(path.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('image1', path));
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key':'api@parthshopping.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> userDocumentUploadPost(String url, var bodyreq, String selfie,String pan, String aadhar,  String salary_slip, String bank_statement,
      String ownership_proof, String relationship_proof,) async {
    print("API =========>>>>>>> $url");
    var uri = Uri.parse(url);
    try {
      var request = http.MultipartRequest("POST", uri);
      if (selfie.isNotEmpty) {
        print("selfie path \n$selfie");
        request.files.add(await http.MultipartFile.fromPath('selfie', selfie));
      }
      if (pan.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('pan', pan));
      }
      if (aadhar.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('aadhar', aadhar));
      }
      if (salary_slip.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('salary_slip', salary_slip));
      }
      if (bank_statement.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('bank_statement', bank_statement));
      }
      if (ownership_proof.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('ownership_proof', ownership_proof));
      }
      if (relationship_proof.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('relationship_proof', relationship_proof));
      }
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key':'api@parthshopping.com',});
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }


  Future<dynamic> employeeDocumentUploadPost(String url, var bodyreq, String pan, String aadhar,  String rent_agreement, String bank_statement,
      String ownership_proof, String relationship_proof,) async {
    print("API =========>>>>>>> $url");
    var uri = Uri.parse(url);
    try {
      var request = http.MultipartRequest("POST", uri);
      if (pan.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('pan', pan));
      }
      if (aadhar.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('aadhar', aadhar));
      }
      if (rent_agreement.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('rent_agreement', rent_agreement));
      }
      if (bank_statement.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('bank_statement', bank_statement));
      }
      if (ownership_proof.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('ownership_proof', ownership_proof));
      }
      if (relationship_proof.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('relationship_proof', relationship_proof));
      }
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key':'api@parthshopping.com',});
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  Future<dynamic> empDocumentUploadPost(String url, var bodyreq, String passport, String pan, String aadhar, String salary_slip, String bank_statement,
      String highSchool, String graduation, String master, String diploma, String reliving, String latter, String real_agrement, String ownership_proof,
      String relationship_proof,) async {
    print("API =========>>>>>>> $url");
    print("relieving =========>>>>>>> $reliving");
    var uri = Uri.parse(url);
    try {
      var request = http.MultipartRequest("POST", uri);
      if (passport.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_passport', passport.toString()));
      }
      if (pan.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_pan', pan.toString()));
      }
      if (aadhar.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_aadhar', aadhar.toString()));
      }
      if (salary_slip.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_salaryslip', salary_slip.toString()));
      }
      if (bank_statement.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_banking', bank_statement.toString()));
      }
      if (highSchool.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_10th_proof', highSchool.toString()));
      }
      if (graduation.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_graduation_proof', graduation.toString()));
      }
      if (master.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_masters_proof', master.toString()));
      }
      if (diploma.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_12th_proof', diploma.toString()));
      }
      if (reliving.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('emp_reliving_letter', reliving.toString()));
      }
      if (latter.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_phd_proof', latter.toString()));
      }
      if (ownership_proof.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_ohp', ownership_proof.toString()));
      }
      if (real_agrement.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_rent_agreement', real_agrement.toString()));
      }
      if (relationship_proof.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('doc_relation_proof', relationship_proof.toString()));
      }
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key':'api@parthshopping.com'});
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    } on BadRequestException {
      throw ApiNotRespondingException("API bad request in this body", uri.toString());
    }
  }
  Future<dynamic> partnerDocumentUploadPost(String url, var bodyreq, String pan, String aadhar,  String rent_agreement, String bank_statement,
      String ownership_proof, String relationship_proof,) async {
    print("API =========>>>>>>> $url");
    var uri = Uri.parse(url);
    try {
      var request = http.MultipartRequest("POST", uri);
      if (pan.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('pan', pan));
      }
      if (aadhar.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('aadhar', aadhar));
      }
      if (bank_statement.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('bank_statement', bank_statement));
      }
      if (ownership_proof.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('ownership_proof', ownership_proof));
      }
      if (rent_agreement.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('rent_agreement', rent_agreement));
      }
      if (relationship_proof.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('relationship_proof', relationship_proof));
      }
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key':'api@parthshopping.com',});
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }


  Future<dynamic> updateLeadStatusPost(String url, var bodyreq, String loginPath, String sanctionedPath, String disbursedPath) async {
    print("API =========>>>>>>> $url");
    var uri = Uri.parse(url);
    try {
      var request = http.MultipartRequest("POST", uri);
      if (sanctionedPath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('sync_latter', sanctionedPath));
      }
      if (disbursedPath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('disb_latter', disbursedPath));
      }
      if (loginPath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('application_form', loginPath));
      }
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key':'api@parthshopping.com',});
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }


}