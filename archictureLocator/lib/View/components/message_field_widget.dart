import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/ViewModel/message_viewmodel.dart';

class MessageField extends StatefulWidget {
  final String cryptoId;
  final User user;
  const MessageField({Key key, @required this.cryptoId, this.user})
      : super(key: key);

  @override
  _MessageFieldState createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final MessageViewModel _mvm = MessageViewModel();
  final _controller = TextEditingController();
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Message",
              ),
              onChanged: (value) => {
                    setState(() {
                      message = value;
                    })
                  }),
        ),
        GestureDetector(
          child: const Icon(Icons.send),
          onTap: () => message.trim().isEmpty ? null : sendMessage(widget.user),
        )
      ],
    );
  }

  void sendMessage(User user) async {
    var pseudo = user.pseudo;
    FocusScope.of(context).unfocus(); // enleve le focus du clavier
    _mvm.sendMessage(widget.cryptoId, message, pseudo);
    _controller.clear();
    message = "";
  }
}
