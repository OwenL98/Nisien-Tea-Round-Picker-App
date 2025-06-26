import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http_client;
import 'package:nisien_tea_round_picker_app/external/tea_picker/models/picker_request.dart';
import 'package:nisien_tea_round_picker_app/external/tea_picker/models/picker_response.dart';

//Enables localhost to be hit via http from emulator
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<String> participantSelector(List<String> participants) async {
  var request = PickerRequest(participants: participants);

  final response = await http_client.post(
    Uri.parse('https://10.0.2.2:7100/v1/random/participant'),
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
