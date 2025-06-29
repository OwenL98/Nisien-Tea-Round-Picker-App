import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/data/history_storage.dart';
import 'package:nisien_tea_round_picker_app/data/participant_storage.dart';
import 'package:nisien_tea_round_picker_app/domain/participant.dart';
import 'package:nisien_tea_round_picker_app/external/tea_picker/tea_round_picker.dart';
import 'package:nisien_tea_round_picker_app/pages/participant_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Nisien Tea Round Picker')),
      body: HomePageBody(
        participantListStorage: ParticipantListStorage(),
        historyStorage: HistoryStorage(),
      ),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({
    super.key,
    required this.participantListStorage,
    required this.historyStorage,
  });

  final ParticipantListStorage participantListStorage;
  final HistoryStorage historyStorage;

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  List<Participant> participantList = List.empty();
  List<Participant> selectedParticipantsList = <Participant>[];
  Participant selectedParticipant = Participant(name: '');
  var isSelectedParticipantSet = false;

  void selectRandomParticipant() async {
    var name = await participantSelector(selectedParticipantsList);

    selectedParticipant = participantList.firstWhere((e) => e.name == name);
    isSelectedParticipantSet = true;

    addToHistory(selectedParticipant);
    setState(() {});
  }

  void addToHistory(Participant participantName) async {
    var storedHistory = await widget.historyStorage.readHistory();

    storedHistory.participantList.add(participantName);

    widget.historyStorage.writeHistory(storedHistory);
  }

  String generateDrinkList() {
    final buffer = StringBuffer();

    for (var participant in selectedParticipantsList) {
      var favouriteDrink =
          participant.favouriteDrink == ''
              ? 'No favourite drink'
              : participant.favouriteDrink;

      buffer.write('${participant.name} : $favouriteDrink');
      buffer.writeln();
    }
    var text = buffer.toString();
    buffer.clear();

    return text;
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
            flex: 8,
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
                    subtitle:
                        isSelectedParticipantSet
                            ? Text('${participant.favouriteDrink}')
                            : null,
                    enabled: !isSelectedParticipantSet,
                    onTap: () {
                      if (selectedParticipantsList.contains(participant)) {
                        selectedParticipantsList.remove(participant);
                      } else {
                        selectedParticipantsList.add(participant);
                      }
                      setState(() {});
                    },
                    onLongPress:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ParticipantDetailsPage(
                                  participant: participant,
                                ),
                          ),
                        ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: selectedParticipantsList.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: SingleChildScrollView(
                    child:
                        isSelectedParticipantSet
                            ? Text(
                              selectedParticipant.name,
                              style: TextStyle(color: Colors.red, fontSize: 50),
                              softWrap: true,
                            )
                            : Text(generateDrinkList()),
                  ),
                ),
                Row(
                  children: [
                    Visibility(
                      visible: selectedParticipant != Participant(name: ''),
                      child: Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed:
                              () => setState(() {
                                selectedParticipant = Participant(name: '');
                                selectedParticipantsList.clear();
                                isSelectedParticipantSet = false;
                              }),
                          child: Text('Reset'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isSelectedParticipantSet,
            child: Expanded(
              flex: 2,
              child:
                  selectedParticipantsList.length > 1
                      ? TextButton(
                        onPressed: () {
                          selectRandomParticipant();
                        },
                        child: Text('Pick Tea Maker'),
                      )
                      : Text('Add and select team members'),
            ),
          ),
        ],
      ),
    );
  }
}
