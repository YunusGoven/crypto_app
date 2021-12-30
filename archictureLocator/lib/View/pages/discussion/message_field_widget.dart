import 'package:flutter/material.dart';
import 'package:mvvm/Model/user.dart';
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
  var isHover = false;
  @override
  Widget build(BuildContext context) {
    var hovered = Matrix4.identity()..translate(0, -4, 0);
    var transform = isHover ? hovered : Matrix4.identity();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                maxLines: 2,
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
          const SizedBox(
            width: 50,
          ),
          MouseRegion(
            onEnter: (event) => setState(() {
              isHover = !isHover;
            }),
            onExit: (event) => setState(() {
              isHover = !isHover;
            }),
            child: AnimatedContainer(
                transform: transform,
                duration: Duration(milliseconds: 200),
                child: GestureDetector(
                  child: const Icon(Icons.send),
                  onTap: () =>
                      message.trim().isEmpty ? null : sendMessage(widget.user),
                )),
          ),
        ],
      ),
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
