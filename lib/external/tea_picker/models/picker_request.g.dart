// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picker_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickerRequest _$PickerRequestFromJson(Map<String, dynamic> json) =>
    PickerRequest(
      participants:
          (json['participants'] as List<dynamic>)
              .map((e) => e as Participant)
              .toList(),
    );

Map<String, dynamic> _$PickerRequestToJson(PickerRequest instance) =>
    <String, dynamic>{'participants': instance.participants};
