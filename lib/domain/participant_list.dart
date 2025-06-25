import 'package:json_annotation/json_annotation.dart';
import 'package:nisien_tea_round_picker_app/domain/participant.dart';

part 'participant_list.g.dart';

@JsonSerializable()
class ParticipantList {
  final List<Participant> participantList;

  ParticipantList(this.participantList);

  factory ParticipantList.fromJson(json) =>
      _$ParticipantListFromJson({'participantList': json});

  toJson() => _$ParticipantListToJson(this)['participantList'];
}
