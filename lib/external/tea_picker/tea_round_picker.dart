import 'dart:convert';
import 'package:http/http.dart' as http_client;
import 'package:nisien_tea_round_picker_app/domain/participant.dart';
import 'package:nisien_tea_round_picker_app/external/tea_picker/models/picker_request.dart';
import 'package:nisien_tea_round_picker_app/external/tea_picker/models/picker_response.dart';

Future<String> participantSelector(List<Participant> participants) async {
  var request = PickerRequest(participants: participants);
  const String uri = 'https://10.0.2.2:7100/v1/random/participant';

  final response = await http_client.post(
    Uri.parse(uri),
    body: jsonEncode(request),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    var picker = PickerResponse.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
    return picker.name;
  } else {
    throw Exception({response.statusCode});
  }
}
