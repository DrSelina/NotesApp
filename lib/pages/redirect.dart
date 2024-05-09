

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app_1/main_dep.dart';
import 'package:test_app_1/pages/home_pg.dart';
import 'package:test_app_1/pages/login_page.dart';


final dio = Dio();
dynamic response;

Future resp() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  response = await dio.get('https://fastapi-simple-notes.vercel.app/users/me/', data: {'Authorization' : ' Bearer $token'});
}

class Redirect extends StatelessWidget {
  const Redirect({super.key});
  @override
  Widget build(BuildContext context) {
    resp();
    if (response.statusCode == 200) {
      return const Home();
    } else {
      return Login();
    }
  }
}
