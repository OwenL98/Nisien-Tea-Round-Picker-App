import 'dart:convert';
import 'dart:io';
import 'package:nisien_tea_round_picker_app/domain/participant.dart';
import 'package:nisien_tea_round_picker_app/domain/participant_list.dart';
import 'package:path_provider/path_provider.dart';

class ParticipantListStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/participantList.txt');
  }

  Future<File> getFile() async {
    return await _localFile;
  }

  Future<ParticipantList> readParticipantList() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();

      final decodedParticipantList = jsonDecode(contents);

      var participantList = ParticipantList.fromJson(decodedParticipantList);
      return participantList;
    } catch (e) {
      return ParticipantList([]);
    }
  }

  Future<void> writeParticipantList(Participant participant) async {
    final file = await _localFile;

    var storedParticipantList = await readParticipantList();

    var x = storedParticipantList.participantList;
    x.add(participant);

    var list = ParticipantList(x);

    var serialised = json.encode(list);

    // Write the file
    await file.writeAsString(serialised);
  }
}
