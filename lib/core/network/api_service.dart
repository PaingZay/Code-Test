import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:interview_test/core/enums/enum.dart';

class ApiService {
  Future<http.Response> apiCall({
    required String url,
    required HttpMethod method,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    Map<String, String> baseHeaders = {};
    if (body != null) {
      baseHeaders['Content-Type'] = 'application/json';
    }

    if (headers != null) {
      baseHeaders.addAll(headers);
    }

    Uri uri = Uri.parse(url);

    try {
      String? bodyJson;
      if (body != null) {
        if (body is String) {
          bodyJson = body;
        } else {
          bodyJson = json.encode(body);
        }
      }

      switch (method) {
        case HttpMethod.POST:
          return await http.post(uri, headers: baseHeaders, body: bodyJson);
        case HttpMethod.GET:
          return await http.get(uri, headers: baseHeaders);
        case HttpMethod.PUT:
          return await http.put(uri, headers: baseHeaders, body: bodyJson);
        case HttpMethod.DELETE:
          return await http.delete(uri, headers: baseHeaders);
        default:
          throw UnsupportedError("Unsupported HTTP method");
      }
    } catch (e) {
      throw Exception("API call failed: $e");
    }
  }
}

// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:interview_test/core/enums/enum.dart';

// class ApiService {
//   Future<http.Response> apiCall({
//     required String url,
//     required HttpMethod method,
//     Map<String, String>? headers,
//     dynamic body,
//   }) async {
//     Map<String, String> baseHeaders = {"Content-Type": "application/json"};

//     if (headers != null) {
//       baseHeaders.addAll(headers);
//     }

//     Uri uri = Uri.parse(url);

//     try {
//       String? bodyJson;
//       if (body != null) {
//         if (body is String) {
//           bodyJson = body;
//         } else {
//           bodyJson = json.encode(body);
//         }
//       }

//       switch (method) {
//         case HttpMethod.POST:
//           return await http.post(uri, headers: baseHeaders, body: bodyJson);
//         case HttpMethod.GET:
//           return await http.get(uri, headers: baseHeaders);
//         case HttpMethod.DELETE:
//           return await http.delete(uri, headers: baseHeaders);
//         case HttpMethod.PUT:
//           return await http.put(uri, headers: baseHeaders, body: bodyJson);
//       }
//     } catch (error) {
//       throw Exception("API call failed: $error");
//     }
//   }
// }
