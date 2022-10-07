import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:programming_hero_quiz_app/utils.dart';
import 'dart:convert' as convert;

class ApiService{
  makeApiRequest({method, url, body, headers, model}) async {
    try {
      http.Response? response;
      Uri apiURL = Uri.parse(url);
      var header = headers;
      if (method == apiMethods.get) {
        response = await http.get(apiURL, headers: header);
        print("my response code is ${response.statusCode}");
        print('response code from function: ${response.body}');
      }

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        // var res = ;
        // print("my response is ${convert.jsonDecode(response.body)}");
        return response.body;
      } else if (response != null && (response.statusCode == 403)) {
        var res = convert.jsonDecode(response.body);
        print("my response is $res");
        return response.body;
      }
      else if(response != null && response.statusCode == 409){
        var res = convert.jsonDecode(response.body);
        print("my response is $res");
        return response.body;
      }
      else if(response!.statusCode == 401){
        var res = convert.jsonDecode(response.body);
        print("my response is $res");
        return response.body;
      }
      else if(response.statusCode == 404){
        var res = convert.jsonDecode(response.body);
        print("my response is $res");
        return response.body;
      }
      else {
        var res = convert.jsonDecode(response.body);

        handleError(res);
      }
    } catch (e) {
      print(e.toString());
      handleError(e);
    }
  }

  handleError(err) {
    var message = 'Something went wrong. Please try again later';
    print(message);
    if (err != null && err['messages'] != null && err['messages'].length > 0) {
      message = err['messages'][0];
    }
    Fluttertoast.showToast(msg: message);
  }
}