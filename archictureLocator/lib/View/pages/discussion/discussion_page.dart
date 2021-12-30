import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Model/user.dart';
import 'package:mvvm/View/pages/discussion/message_field_widget.dart';
import 'package:mvvm/View/pages/discussion/message_widget.dart';
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

                  return MessageWidget(
                    isCurrentUser: isCurrentUser,
                    mesg: mesg,
                    sender: sender,
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
