import 'package:http/http.dart' as http;

Future<http.Response> fetchAlbum() {
  final response = http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );
  print(response.toString());
  return response;
}
