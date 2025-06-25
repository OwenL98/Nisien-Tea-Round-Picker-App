import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/data/participant_storage.dart';
import 'package:nisien_tea_round_picker_app/domain/participant.dart';
import 'package:nisien_tea_round_picker_app/domain/participant_list.dart';

class ParticipantsPage extends StatelessWidget {
  const ParticipantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ParticipantsPageBody(
      participantListStorage: ParticipantListStorage(),
    );
  }
}

class ParticipantsPageBody extends StatefulWidget {
  const ParticipantsPageBody({super.key, required this.participantListStorage});

  final ParticipantListStorage participantListStorage;

  @override
  State<ParticipantsPageBody> createState() => __ParticipantsPageBodyState();
}

class __ParticipantsPageBodyState extends State<ParticipantsPageBody> {
  List<Participant>? participantList;

  void readParticipantListFromStorage() async {
    var file = await widget.participantListStorage.getFile();
    if (file.existsSync()) {
      var storedParticipantList =
          await widget.participantListStorage.readParticipantList();
      setState(() {
        participantList = storedParticipantList.participantList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: participantList!.length,
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) {
                final participant = participantList![index];
                return ListTile(title: Text(participant.name));
              },
            ),
          ),
        ],
      ),
    );
  }
}
