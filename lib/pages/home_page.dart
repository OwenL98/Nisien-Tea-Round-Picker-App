import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/common/debuncer.dart';
import 'package:nisien_tea_round_picker_app/data/participant_storage.dart';
import 'package:nisien_tea_round_picker_app/domain/participant.dart';
import 'package:nisien_tea_round_picker_app/domain/participant_list.dart';
import 'package:nisien_tea_round_picker_app/external/tea_round_picker.dart';

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
  final controller = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  final FocusNode _focusNode = FocusNode();
  List<Participant> participantList = [];

  var nameList = <String>[];
  var selectedName = '';

  void addToNameList(String name) {
    nameList.add(name);

    setState(() {});
  }

  void generateName() async {
    var name = await picker(nameList);

    setState(() {
      selectedName = name;
    });
  }

  void readParticipantListFromStorage() async {
    var storedParticipantList =
        await widget.participantListStorage.readParticipantList();

    print('storedList: ${storedParticipantList}');
    setState(() {
      participantList = storedParticipantList.participantList;
    });

    print('storedLocal: ${participantList}');
  }

  void addParticipantToList(Participant participant) async {
    await widget.participantListStorage.writeParticipantList(participant);
    readParticipantListFromStorage();
  }

  bool isListNotEmpty() {
    // print('length ${participantList.participantList.length}');
    // return participantList.participantList.isNotEmpty;
    return true;
  }

  @override
  void initState() {
    //readParticipantListFromStorage();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
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
              visible: isListNotEmpty(),
              child: ListView.builder(
                itemCount: participantList.length,
                shrinkWrap: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (context, index) {
                  final participant = participantList[index];
                  return ListTile(title: Text(participant.name));
                },
              ),
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
                        () => _debouncer.run(() {
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
                ),
                onSubmitted: (value) {
                  _debouncer.run(() {
                    addToNameList(controller.text);
                    controller.text = '';
                  });
                },
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  controller.text = value;
                },
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                selectedName = '';
              });
              generateName();
            },
            child: Text('Pick Tea Maker'),
          ),

          Text(selectedName),
        ],
      ),
    );
  }
}//TODO: enter one name at a time
//TODO: display list of names
//TODO: remove name from list
//TODO: 'generate' button to call api
