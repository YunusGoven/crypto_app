import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/View/components/message_field_widget.dart';
import 'package:mvvm/ViewModel/message_viewmodel.dart';
import 'package:provider/provider.dart';

class DiscussionPage extends StatefulWidget {
  final String cryptoId;
  const DiscussionPage({Key key, this.cryptoId}) : super(key: key);

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  final MessageViewModel _mvm = MessageViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Column(children: [
      StreamBuilder<QuerySnapshot>(
        stream: _mvm.getMessages(widget.cryptoId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              List<DocumentSnapshot> message = snapshot.data.docs;
              return Flexible(
                  child: ListView.builder(
                padding: const EdgeInsets.all(10),
                reverse: true,
                itemCount: message.length < 100 ? message.length : 100,
                itemBuilder: (context, index) {
                  var mesg = message[index].get('message');
                  var sender = message[index].get('idUser');
                  String currentUser = user.pseudo;
                  var isCurrentUser = sender == currentUser;

                  return Column(
                    crossAxisAlignment: isCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
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
                          alignment: isCurrentUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: isCurrentUser
                                  ? Colors.blue
                                  : Colors.grey[300],
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                              color: isCurrentUser
                                                  ? Colors.white
                                                  : Colors.black87),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
      MessageField(
        user: user,
        cryptoId: widget.cryptoId,
      )
    ]);
  }
}
