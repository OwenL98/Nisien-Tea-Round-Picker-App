import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/data/history_storage.dart';
import 'package:nisien_tea_round_picker_app/domain/participant.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('History')),
      body: HistoryPageBody(historyStorage: HistoryStorage()),
    );
  }
}

class HistoryPageBody extends StatefulWidget {
  const HistoryPageBody({super.key, required this.historyStorage});
  final HistoryStorage historyStorage;
  @override
  State<HistoryPageBody> createState() => _HistoryPageBodyState();
}

class _HistoryPageBodyState extends State<HistoryPageBody> {
  var history = List<Participant>.empty();

  Future<List<Participant>> readHistory() async {
    var participantHistory = await widget.historyStorage.readHistory();
    history = participantHistory.participantList;
    widget.historyStorage.readHistory().then((value) {
      setState(() {
        history = value.participantList;
      });
    });
    return participantHistory.participantList;
  }

  @override
  void initState() {
    readHistory();
    super.initState();
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
            child: ListView.builder(
              itemCount: history.length,
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) {
                final participant = history[index];
                return ListTile(title: Text(participant.name));
              },
            ),
          ),
        ],
      ),
    );
  }
}
