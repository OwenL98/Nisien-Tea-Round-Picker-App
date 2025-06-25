import 'package:json_annotation/json_annotation.dart';

part 'participant.g.dart';

@JsonSerializable(explicitToJson: true)
class Participant {
  final String name;
  String? favouriteDrink;

  Participant({required this.name, this.favouriteDrink});

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);

  @override
  bool operator ==(Object other) =>
      other is Participant &&
      other.runtimeType == runtimeType &&
      other.name == name;

  @override
  int get hashCode => name.hashCode;
}
