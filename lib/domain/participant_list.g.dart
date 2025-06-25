// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantList _$ParticipantListFromJson(Map<String, dynamic> json) =>
    ParticipantList(
      (json['participantList'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParticipantListToJson(ParticipantList instance) =>
    <String, dynamic>{'participantList': instance.participantList};
