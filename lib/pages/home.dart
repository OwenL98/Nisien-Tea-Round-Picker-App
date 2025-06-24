import 'package:flutter/material.dart';
import 'package:nisien_tea_round_picker_app/common/debuncer.dart';
import 'package:nisien_tea_round_picker_app/external/tea_round_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Nisien Tea Round Picker')),
      body: HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final controller = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  final FocusNode _focusNode = FocusNode();

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
          Text(nameList.toString()),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed:
                    () => _debouncer.run(() {
                      addToNameList(controller.text);
                    }),
                icon: Icon(Icons.search),
              ),
              labelText: 'testing',
              //errorText: _showValidationError ? 'invalid' : null,
            ),
            onSubmitted: (value) {
              _debouncer.run(() {
                addToNameList(controller.text);
              });
            },
            focusNode: _focusNode,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              controller.text = value;
            },
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
