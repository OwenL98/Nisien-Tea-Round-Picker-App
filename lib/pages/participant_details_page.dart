import 'package:flutter/material.dart';

class ParticipantDetailsPage extends StatelessWidget {
  const ParticipantDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Team Memeber Details')),
      body: ParticipantDetailsPageBody(),
    );
  }
}

class ParticipantDetailsPageBody extends StatefulWidget {
  const ParticipantDetailsPageBody({super.key});

  @override
  State<ParticipantDetailsPageBody> createState() =>
      _ParticipantDetailsPageBodyState();
}

class _ParticipantDetailsPageBodyState
    extends State<ParticipantDetailsPageBody> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
