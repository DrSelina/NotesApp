import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_app_1/main_dep.dart';
import 'package:test_app_1/pages/home_pg.dart';
import 'package:test_app_1/pages/signup_page.dart';
import 'package:test_app_1/token_verif.dart';
import 'package:test_app_1/widgets/text_form_f.dart';

final dio = Dio();
final talker = TalkerFlutter.init();

class Login extends StatelessWidget {
  Login({super.key});
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Log In",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFF(
                controller: controller1,
                hintText: "Login",
              ),
              const SizedBox(
                height: 12,
              ),
              TextFF(
                controller: controller2,
                hintText: "Password",
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.blue,
                ),
                child: TextButton(
                  onPressed: () async {
                    try {
                      final response = await dio.post(
                          "https://fastapi-simple-notes.vercel.app/token/",
                          data:
                              'grant_type=&username=${controller1.text}&password=${controller2.text}&scope=&client_id=&client_secret=',
                          options: Options(
                              headers: {
                                "Content-Type": "x-www-form-urlencoded"
                              },
                              contentType: Headers
                                  .formUrlEncodedContentType) // ContentType.parse("x-www-form-urlencoded"))
                          );
                      talker.log(response);
                      if (response.statusCode == 200) {
                        await tokenAddL(response);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Home(),
                          ),
                        );
                      }
                    } catch (error) {
                      talker.error(error);
                    }
                  },
                  child: const Text(
                    "Enter",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Align(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Signup(),
                          ),
                        );
                      },
                      child: const Text(
                        "Don't have account?",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
              const SizedBox(
                height: 160,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Home(),
                    ),
                  );
                },
                child: const Text("redirect"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
