import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/common/debuncer.dart';
import 'package:nisien_tea_round_picker_app/data/participant_storage.dart';
import 'package:nisien_tea_round_picker_app/domain/participant.dart';
import 'package:nisien_tea_round_picker_app/pages/participant_details_page.dart';

class ParticipantsPage extends StatelessWidget {
  const ParticipantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Team Members')),
      body: ParticipantsPageBody(
        participantListStorage: ParticipantListStorage(),
      ),
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
  final controller = TextEditingController();
  final Debouncer debouncer = Debouncer(milliseconds: 500);
  final FocusNode focusNode = FocusNode();
  List<Participant> participantList = List.empty();

  void readParticipantListFromStorage() {
    widget.participantListStorage.readParticipantList().then((value) {
      setState(() {
        participantList = value.participantList;
      });
    });
  }

  void addParticipantToList(Participant participant) async {
    if (participantList.contains(participant)) {
      return;
    }

    var storedList = await widget.participantListStorage.readParticipantList();

    storedList.participantList.add(participant);
    widget.participantListStorage.writeParticipantList(storedList);
    setState(() {});
    readParticipantListFromStorage();
  }

  void removeFromParticipant(Participant participant) async {
    var storedList = await widget.participantListStorage.readParticipantList();

    storedList.participantList.remove(participant);
    widget.participantListStorage.writeParticipantList(storedList);

    readParticipantListFromStorage();
  }

  Text? displayFavouriteDrink(Participant participant) {
    if (participant.favouriteDrink != null ||
        participant.favouriteDrink != '') {
      return Text(participant.favouriteDrink!);
    }
    return null;
  }

  bool isValid() {
    if (controller.value.text.trim().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.participantListStorage.readParticipantList().then((value) {
      setState(() {
        participantList = value.participantList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: participantList.length,
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) {
                final participant = participantList[index];
                return ListTile(
                  title: Text(participant.name),
                  subtitle: displayFavouriteDrink(participant),
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ParticipantDetailsPage(
                                participant: participant,
                              ),
                        ),
                      ).then((_) {
                        setState(() {});
                      }),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => removeFromParticipant(participant),
                        icon: Icon(Icons.delete_outline),
                        iconSize: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed:
                        () => debouncer.run(() {
                          addParticipantToList(
                            Participant(
                              name: controller.text,
                              favouriteDrink: '',
                            ),
                          );
                          controller.text = '';
                        }),
                    icon: Icon(Icons.check),
                  ),
                  labelText: 'Enter team member name',
                  errorText: isValid() ? 'invalid' : null,
                ),
                onSubmitted: (value) {
                  debouncer.run(() {
                    addParticipantToList(
                      Participant(name: controller.text, favouriteDrink: ''),
                    );
                    controller.text = '';
                  });
                },
                focusNode: focusNode,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  controller.text = value;
                },
                maxLength: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
