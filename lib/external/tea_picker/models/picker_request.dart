import 'package:json_annotation/json_annotation.dart';

part 'picker_request.g.dart';

@JsonSerializable()
class PickerRequest {
  final List<String> participants;

  const PickerRequest({required this.participants});
  Map<String, dynamic> toJson() => _$PickerRequestToJson(this);
}
