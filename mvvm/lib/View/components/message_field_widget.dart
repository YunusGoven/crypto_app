import 'package:flutter/material.dart';
import 'package:mvvm/ViewModel/message_viewmodel.dart';

class MessageField extends StatefulWidget {
  final String cryptoId;
  const MessageField({Key key, @required this.cryptoId}) : super(key: key);

  @override
  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final MessageViewModel _mvm = MessageViewModel();
  var _controller = TextEditingController();
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Message",
              ),
              onChanged: (value) => {
                    setState(() {
                      message = value;
                    })
                  }),
        ),
        GestureDetector(
          child: Icon(Icons.send),
          onTap: message.trim().isEmpty ? null : sendMessage,
        )
      ],
    );
  }

  void sendMessage() async {
    FocusScope.of(context).unfocus(); // enleve le focus du clavier
    //await FirebaseApi.sendMessage(widget.cryptoId, message);
    _mvm.sendMessage(widget.cryptoId, message);
    _controller.clear();
    message = "";
  }
}
