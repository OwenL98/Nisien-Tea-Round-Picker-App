import 'dart:convert';
import 'dart:io';
import 'package:nisien_tea_round_picker_app/domain/participant_list.dart';
import 'package:path_provider/path_provider.dart';

class HistoryStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/history.txt');
  }

  Future<File> getFile() async {
    return await _localFile;
  }

  Future<ParticipantList> readHistory() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();

      final decodedHistory = jsonDecode(contents);

      var participantList = ParticipantList.fromJson(decodedHistory);

      return participantList;
    } catch (e) {
      return ParticipantList([]);
    }
  }

  Future<void> writeHistory(ParticipantList participantName) async {
    final file = await _localFile;

    var serialised = json.encode(participantName);

    await file.writeAsString(serialised);
  }
}
