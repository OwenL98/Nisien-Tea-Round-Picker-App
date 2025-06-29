import 'package:json_annotation/json_annotation.dart';
import 'package:nisien_tea_round_picker_app/domain/participant.dart';

part 'picker_request.g.dart';

@JsonSerializable()
class PickerRequest {
  final List<Participant> participants;

  const PickerRequest({required this.participants});

  factory PickerRequest.fromJson(Map<String, dynamic> json) =>
      _$PickerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PickerRequestToJson(this);
}
