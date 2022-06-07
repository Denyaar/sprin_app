import 'package:http/http.dart' as http;

class APIService{
  final String _baseUrl= "http://localhost:8080/products";
  Map<String, String> headers ={
    "content-type":"application/json",
    "accept" : "application/json",
  };

  Future<http.Response> get(String url, Map<String, String> params)async{
    try{
     Uri uri = Uri.parse(_baseUrl + url).replace(queryParameters: params);
     http.Response response =await http.get(uri);
     return response;
    }catch(e){
      return http.Response({"message":e}.toString(), 400);
    }

  }

}