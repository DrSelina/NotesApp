import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();
void Log(String DATA, int log_point_number, String successfulText) {
  talker.log(
      'log_point_$log_point_number, $successfulText successful, DATA: {$DATA}');
}
