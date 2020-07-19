import 'package:flutter/material.dart';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  String _donorId = "D1234";
  TextEditingController _controller = TextEditingController();
  List<Msg> _messages = <Msg>[];
  bool _isWriting = false;

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
                icon: Icon(Icons.send),
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

    Msg msg = Msg(
        txt: watsonAssistantResponse.resultText,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 800)),
        isRequest: false);
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
    watsonAssistantContext = watsonAssistantResponse.context;
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
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.green[100]),
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(txt,
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
            ),
          )
        ],
      ),
    );
  }
}
