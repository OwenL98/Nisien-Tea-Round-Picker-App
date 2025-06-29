import 'package:json_annotation/json_annotation.dart';

part 'picker_response.g.dart';

@JsonSerializable()
class PickerResponse {
  final String name;

  const PickerResponse({required this.name});

  factory PickerResponse.fromJson(Map<String, dynamic> json) =>
      _$PickerResponseFromJson(json);

  toJson() => _$PickerResponseToJson(this)['name'];
}
