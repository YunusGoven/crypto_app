import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final bool isCurrentUser;
  final String sender;
  final String mesg;
  const MessageWidget(
      {Key key,
      @required this.isCurrentUser,
      @required this.sender,
      @required this.mesg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            sender,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            isCurrentUser ? 64.0 : 16.0,
            4,
            isCurrentUser ? 16.0 : 64.0,
            4,
          ),
          child: Align(
            alignment:
                isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isCurrentUser ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: isCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        mesg,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color:
                                isCurrentUser ? Colors.white : Colors.black87),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
