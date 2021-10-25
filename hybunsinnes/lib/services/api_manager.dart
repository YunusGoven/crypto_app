/* import 'dart:convert';
import 'package:http/http.dart' as http;

var now = DateTime.now();
var count = 5;
var past = DateTime(now.year, now.month, now.day - count);

String present =
    now.year.toString() + "-" + now.month.toString() + "-" + now.day.toString();

String before = past.year.toString() +
    "-" +
    past.month.toString() +
    "-" +
    past.day.toString();

class ApiManager {
  Future<dynamic> getApods() async {
    var url = Uri.parse('http://askmo.be:3000/apod?start_date=' +
        before +
        '&end_date=' +
        present);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      var apods = (json.decode(response.body) as List)
          .map((apod) => ApodItemModel.fromJson(apod))
          .toList();
      return apods;
    }
    return 'fetch error';
  }

  Future<dynamic> getApod(String id) async {
    var url = Uri.parse('http://askmo.be:3000/apod/' + id);

    var response = await http.get(url);

    // ignore: avoid_print
    print('getApod | response: ' +
        response.body +
        'statusCode:' +
        response.statusCode.toString());

    if (response.statusCode == 200) {
      var apod = ApodItemModel.fromJson(json.decode(response.body));
      return apod;
    }

    // something wrong happened
    return 'Could not fetch apod' + id + '. Make sure it exists';
  }
}
 */