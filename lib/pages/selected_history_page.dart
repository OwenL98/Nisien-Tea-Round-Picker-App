import 'package:flutter/material.dart';

class SelectedHistoryPage extends StatelessWidget {
  const SelectedHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('History')),
      body: SelectedHistoryPageBody(),
    );
  }
}

class SelectedHistoryPageBody extends StatefulWidget {
  const SelectedHistoryPageBody({super.key});

  @override
  State<SelectedHistoryPageBody> createState() =>
      _SelectedHistoryPageBodyState();
}

class _SelectedHistoryPageBodyState extends State<SelectedHistoryPageBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Expanded(flex: 5, child: Text('data'))],
      ),
    );
  }
}
