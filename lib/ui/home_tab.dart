import 'package:carambar/ui/presenter/age_event_presenter.dart';
import 'package:carambar/ui/presenter/character_presenter.dart';
import 'package:carambar/ui/presenter/display_age_event.dart';
import 'package:carambar/ui/widget/age_event_list.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  CharacterPresenter _characterPresenter;
  AgeEventPresenter _ageEventPresenter;

  @override
  void initState() {
    super.initState();

    var container = kiwi.Container();
    _characterPresenter = container.resolve("characterPresenter");
    _ageEventPresenter = container.resolve("ageEventPresenter");
  }

  void _onAgeButtonClick() async {
    await _characterPresenter.incrementAge();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<DisplayAgeEvent>>(
          future: _ageEventPresenter.getDisplayAgeEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AgeEventList(displayAgeEvents: snapshot.data);
            } else {
              return Text("Loading...");
            }
          }),
      bottomNavigationBar: MaterialButton(
        key: Key("ageButton"),
        color: Colors.lightBlue,
        onPressed: _onAgeButtonClick,
        child: Text(
          "Age",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
