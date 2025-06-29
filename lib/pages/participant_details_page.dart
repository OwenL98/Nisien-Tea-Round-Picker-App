import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/common/debuncer.dart';
import 'package:nisien_tea_round_picker_app/data/participant_storage.dart';
import 'package:nisien_tea_round_picker_app/domain/participant.dart';

class ParticipantDetailsPage extends StatelessWidget {
  const ParticipantDetailsPage({super.key, required this.participant});
  final Participant participant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Team Member Details')),
      body: ParticipantDetailsPageBody(
        participantDetails: participant,
        participantListStorage: ParticipantListStorage(),
      ),
    );
  }
}

class ParticipantDetailsPageBody extends StatefulWidget {
  const ParticipantDetailsPageBody({
    super.key,
    required this.participantDetails,
    required this.participantListStorage,
  });
  final Participant participantDetails;
  final ParticipantListStorage participantListStorage;

  @override
  State<ParticipantDetailsPageBody> createState() =>
      _ParticipantDetailsPageBodyState();
}

class _ParticipantDetailsPageBodyState
    extends State<ParticipantDetailsPageBody> {
  final controller = TextEditingController();
  final Debouncer debouncer = Debouncer(milliseconds: 500);
  final FocusNode focusNode = FocusNode();
  var displayController = false;

  Text displayFavouriteDrink() {
    var favouriteDrink = widget.participantDetails.favouriteDrink;
    if (favouriteDrink == null || favouriteDrink.isEmpty) {
      return Text('no favourite drink set');
    }
    return Text(favouriteDrink);
  }

  void addFavouriteDrink(String favouriteDrink) async {
    var storedParticipantList =
        await widget.participantListStorage.readParticipantList();

    var indexOfParticipant = storedParticipantList.participantList.indexWhere(
      (participant) => participant.name == widget.participantDetails.name,
    );

    storedParticipantList.participantList.removeAt(indexOfParticipant);
    storedParticipantList.participantList.add(
      Participant(
        name: widget.participantDetails.name,
        favouriteDrink: favouriteDrink,
      ),
    );

    widget.participantListStorage.writeParticipantList(storedParticipantList);

    setState(() {
      widget.participantDetails.favouriteDrink = favouriteDrink;
      displayFavouriteDrink();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(flex: 1, child: Column(children: [Text('Name')])),
            Expanded(
              flex: 1,
              child: Column(children: [Text(widget.participantDetails.name)]),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(children: [Text('Favourite Drink')]),
            ),
            Expanded(
              flex: 1,
              child: Column(children: [displayFavouriteDrink()]),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            displayController = true;
            setState(() {});
          },
          child: Text('Update Favourite Drink'),
        ),

        Visibility(
          visible: displayController,
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed:
                      () => debouncer.run(() {
                        addFavouriteDrink(controller.text);
                        controller.text = '';
                        displayController = false;
                        setState(() {});
                      }),
                  icon: Icon(Icons.check),
                ),
                labelText: 'Enter favourite drink',
              ),
              onSubmitted: (value) {
                debouncer.run(() {
                  addFavouriteDrink(controller.text);
                  controller.text = '';
                  displayController = false;
                  setState(() {});
                });
              },
              focusNode: focusNode,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                controller.text = value;
              },
              maxLength: 30,
            ),
          ),
        ),
      ],
    );
  }
}
