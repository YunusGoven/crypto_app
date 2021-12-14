import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/components/message_field_widget.dart';
import 'package:mvvm/ViewModel/message_viewmodel.dart';
import 'package:mvvm/locator.dart';

class DiscussionPage extends StatefulWidget {
  final String cryptoId;
  const DiscussionPage({Key key, this.cryptoId}) : super(key: key);

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  final MessageViewModel _mvm = MessageViewModel();
  final _auth = locator<Auth>();
  Future<User> _user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = getUserInfo();
  }

  Future<User> getUserInfo() async {
    return await _auth.user();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: _user,
        builder: (contextUser, snapshotUser) {
          if (snapshotUser.hasData) {
            return Container(
              child: Column(children: [
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _mvm.getMessages(widget.cryptoId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasData) {
                          List<DocumentSnapshot> message = snapshot.data.docs;
                          return Flexible(
                              child: ListView.builder(
                            padding: EdgeInsets.all(10),
                            reverse: true,
                            itemCount:
                                message.length < 100 ? message.length : 100,
                            itemBuilder: (context, index) {
                              var mesg = message[index].get('message');
                              var sender = message[index].get('idUser');
                              String currentUser = snapshotUser.data.pseudo;
                              var isCurrentUser = sender == currentUser;

                              return Padding(
                                // asymmetric padding
                                padding: EdgeInsets.fromLTRB(
                                  isCurrentUser ? 64.0 : 16.0,
                                  4,
                                  isCurrentUser ? 16.0 : 64.0,
                                  4,
                                ),
                                child: Align(
                                  // align the child within the container
                                  alignment: isCurrentUser
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: DecoratedBox(
                                    // chat bubble decoration
                                    decoration: BoxDecoration(
                                      color: isCurrentUser
                                          ? Colors.blue
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
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
                                            Text(
                                              sender,
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            },
                          ));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                    },
                  ),
                ),
                MessageField(
                  cryptoId: widget.cryptoId,
                )
              ]),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
