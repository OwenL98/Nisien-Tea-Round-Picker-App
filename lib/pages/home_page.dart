import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/data/participant_storage.dart';
import 'package:nisien_tea_round_picker_app/domain/participant.dart';
import 'package:nisien_tea_round_picker_app/external/tea_picker/tea_round_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Nisien Tea Round Picker')),
      body: HomePageBody(participantListStorage: ParticipantListStorage()),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key, required this.participantListStorage});

  final ParticipantListStorage participantListStorage;

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  List<Participant> participantList = [];

  var nameList = <String>[];
  var selectedName = '';

  void selectRandomParticipant() async {
    var name = await participantSelector(nameList);

    setState(() {
      selectedName = name;
    });
  }

  void readParticipantListFromStorage() async {
    var storedParticipantList =
        await widget.participantListStorage.readParticipantList();
    setState(() {
      participantList = storedParticipantList.participantList;
    });
  }

  void addParticipantToList(Participant participant) async {
    var storedList = await widget.participantListStorage.readParticipantList();
    storedList.participantList.add(participant);
    await widget.participantListStorage.writeParticipantList(storedList);
    readParticipantListFromStorage();
  }

  @override
  void initState() {
    readParticipantListFromStorage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Visibility(
              visible: participantList.isNotEmpty,
              child: ListView.builder(
                itemCount: participantList.length,
                shrinkWrap: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (context, index) {
                  final participant = participantList[index];
                  return ListTile(
                    title: Text(participant.name),
                    onTap: () {
                      nameList.add(participant.name);
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectedName = '';
                });
                selectRandomParticipant();
              },
              child: Text('Pick Tea Maker'),
            ),
          ),

          Text(selectedName),
        ],
      ),
    );
  }
}//TODO: enter one name at a time (validation)
//TODO: display list of names
//TODO: remove name from list
