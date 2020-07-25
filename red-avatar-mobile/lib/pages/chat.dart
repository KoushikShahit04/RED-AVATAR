import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redavatar/model/blockchain.donor.dart';
import 'package:redavatar/model/donation.dart';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();
  List<Msg> _messages = <Msg>[];
  bool _isWriting = false;
  String serverAppUrl = 'http://10.0.2.2:8888';

  WatsonAssistantV2Credential watsonCreds = WatsonAssistantV2Credential(
      apikey: "Wraq8se-deX1Q-LeeLgOC100l7YEZ63VAeaiINmcQ7QL",
      assistantID: "3f5b5cf2-0ad8-4d2e-a6c4-b1b47daa71f4",
      url:
          "https://api.jp-tok.assistant.watson.cloud.ibm.com/instances/9dc735a9-00d4-4d38-9506-ecea7a37362d/v2",
      version: "2020-04-01");
  WatsonAssistantApiV2 watsonAssistant;
  WatsonAssistantResponse watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext =
      WatsonAssistantContext(context: {});

  @override
  void initState() {
    super.initState();
    watsonAssistant =
        WatsonAssistantApiV2(watsonAssistantCredential: watsonCreds);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
            reverse: true,
            padding: EdgeInsets.all(6.0),
          ),
        ),
        Divider(height: 1.0),
        Container(
          child: _buildComposer(),
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
        )
      ],
    );
  }

  Widget _buildComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _controller,
                onChanged: (String txt) {
                  setState(() {
                    _isWriting = txt.length > 0;
                  });
                },
                onSubmitted: _submitMsg,
                decoration: InputDecoration.collapsed(
                    hintText: 'Enter your message here'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3.0),
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).accentColor,
                ),
                onPressed:
                    _isWriting ? () => _submitMsg(_controller.text) : null,
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Theme.of(context).accentColor))),
      ),
    );
  }

  void _submitMsg(String txt) {
    _controller.clear();
    setState(() {
      _isWriting = false;
    });
    Msg msg = Msg(
        txt: txt,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 800)),
        isRequest: true);
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
    _callWatsonAssistant(txt);
  }

  void _callWatsonAssistant(String text) async {
    watsonAssistantResponse =
        await watsonAssistant.sendMessage(text, watsonAssistantContext);

    String responseText = watsonAssistantResponse.resultText;
    if (responseText.contains("[")) {
      var response = json.decode(responseText) as List<dynamic>;
      List<String> bloodgroups = response.cast<String>().toList();
      _findBlood(bloodgroups);
    } else {
      Msg msg = Msg(
          txt: watsonAssistantResponse.resultText,
          animationController: AnimationController(
              vsync: this, duration: Duration(milliseconds: 800)),
          isRequest: false);
      setState(() {
        _messages.insert(0, msg);
      });
      msg.animationController.forward();
    }

    watsonAssistantContext = watsonAssistantResponse.context;
  }

  void _findBlood(List<String> bloodgroups) {
    bloodgroups.forEach((group) {
      Map<String, int> map = {};
      List<Donation> donations = [];
      var selector =
          "{\"bloodGroup\": \"$group\", \"donationDetails\": {\"\$elemMatch\": {\"bagStatus\": \"APPROVED\"}}}";
      http.post(serverAppUrl + "/redavatar/blockchain/selector",
          body: "{\"selector\": $selector}",
          headers: {
            "Accept": "application/json"
          }).then((http.Response response) {
        List<BlockchainDonor> donors =
            List<Map<String, dynamic>>.from(json.decode(response.body))
                .map((Map<String, dynamic> e) => BlockchainDonor.fromJson(e))
                .toList();
        donors.forEach((donor) {
          donations.addAll(donor.donationDetails);
        });

        donations.forEach((donation) {
          String key = donation.collectedInstitute;
          int count = map.containsKey(key) ? map.remove(key) : 0;
          map.putIfAbsent(key, () => ++count);
        });

        map.keys.forEach((key) {
          String text;
          if (map[key] == 1) {
            text = "There is ";
          } else {
            text = "There are ";
          }
          text += map[key].toString() +
              " " +
              group +
              " blood bags at " +
              _getInstituteName(key);
          Msg msg = Msg(
              txt: text,
              animationController: AnimationController(
                  vsync: this, duration: Duration(milliseconds: 800)),
              isRequest: false);
          setState(() {
            _messages.insert(0, msg);
          });
          msg.animationController.forward();
        });
      });
    });
  }

  String _getInstituteName(String instId) {
    List<Map<String, String>> centers = [
      {'value': 'I1234', 'text': 'Apollo Hospital'},
      {'value': 'I1235', 'text': 'Kalinga Hospital'},
    ];
    return centers.firstWhere((element) => element['value'] == instId)['text'];
  }

  @override
  void dispose() {
    _controller.dispose();
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController, this.isRequest});
  final String txt;
  final AnimationController animationController;
  final bool isRequest;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
      axisAlignment: 0.0,
      child: Row(
        mainAxisAlignment:
            isRequest ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
                borderRadius: _getBorderRadius(isRequest),
                color: Colors.red[100]),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(txt,
                  softWrap: true,
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
            ),
          )
        ],
      ),
    );
  }

  BorderRadius _getBorderRadius(bool isRequest) {
    double radius = 15.0;
    if (isRequest) {
      return BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius));
    } else {
      return BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius));
    }
  }
}
