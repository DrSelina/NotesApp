import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_app_1/main_dep.dart';
import 'package:test_app_1/notesValRelease.dart';
import 'package:test_app_1/widgets/dialog.dart';

final talker = Talker();
final dio = Dio();
List<String> noteMapT = [];
List<String> noteMapC = [];
List<int> noteMapI = [];
int notesCount = 0;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool switchSerialize = true;
  void notesS() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<JsonInitNote> respconResponse = await VerifC();
      setState(() {
        notesCount = prefs.getInt("amount")!;
      });

      if (switchSerialize == true) {
        for (var e = 0; e < (notesCount); e++) {
          setState(() {
            noteMapT.add("");
          });
          setState(() {
            noteMapC.add("");
          });
          setState(() {
            noteMapI.add(0);
          });
        }
        //talker.log("SS=true, $noteMapT");
        setState(() {
          switchSerialize = false;
        });
      }
      talker.log("Anchor point 1");
      for (var i = 0; i < (notesCount); i++) {
        //talker.log("log note entrance");
        if (noteMapT[i] != respconResponse[i].title) {
          setState(() {
            noteMapT.insert(
              i,
              respconResponse[i].title,
            );
          });
        }
        //talker.log("log note title");
        if (noteMapC[i] != respconResponse[i].content) {
          setState(() {
            noteMapC.insert(
              i,
              respconResponse[i].content,
            );
          });
        }
        //talker.log("log note content");
        if (noteMapI[i] != respconResponse[i].id) {
          setState(() {
            noteMapI.insert(
              i,
              respconResponse[i].id,
            );
          });
        }
        //talker.log("log note id's");
      }
      talker.log('log_point_3,$notesCount');
      talker.log('log_point_4 $noteMapT, $noteMapC, $noteMapI');
    } catch (error) {
      talker.error("error code: 1 $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    var controller2 = TextEditingController();
    //noteCSerialize();
    notesS();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Notes",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: NotesListBuilder(
                      noteMapC: noteMapC,
                      noteMapI: noteMapI,
                      noteMapT: noteMapT,
                      notesCount: notesCount,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                onSave: () async {
                  final response = await dio.post(
                      "https://fastapi-simple-notes.vercel.app/notes/",
                      options: Options(headers: {
                        'Authorization': "Bearer ${prefs.getString("token")}"
                      }),
                      data: {
                        "title": controller.text,
                        "content": controller2.text
                      });
                  talker.log(response);
                  setState(() {
                    switchSerialize = true;
                  });
                  Navigator.of(context).pop();
                },
                controller: controller,
                controller2: controller2,
              );
            },
          );
        },
        icon: const Icon(Icons.add),
      ),
    );
  }
}
