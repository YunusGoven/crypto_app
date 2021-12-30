import 'package:flutter/material.dart';
import 'package:mvvm/ViewModel/user_viewmodel.dart';
import 'package:stacked/stacked.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({Key key}) : super(key: key);

  @override
  _UserListWidgetState createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
      viewModelBuilder: () => UserViewModel(),
      onModelReady: (model) => model.getUsers(),
      disposeViewModel: false,
      builder: (context, model, child) => Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(.75),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(.3),
          3: FlexColumnWidth(.45),
          4: FlexColumnWidth(.45)
        },
        children: [
          const TableRow(children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "UserName",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Center(
              child: Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Center(
              child: Text(
                "Email Confirmed",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Center(
              child: Text(
                "Solde",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Center(
              child: Text(
                "Action",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ]),
          if (model.users != null)
            ...model.users
                .asMap()
                .map((index, user) => MapEntry(
                      index,
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(user.pseudo),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(user.mail),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              user.EmailIsValidate
                                  ? Icons.check_circle_outline_outlined
                                  : Icons.remove_circle_outline_outlined,
                              color: user.EmailIsValidate
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${user.solde} \$"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    var block = await model.blockUser(user.id);
                                    final snackBar = SnackBar(
                                      content: Text(
                                        block.value,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      backgroundColor: block.code == 200
                                          ? Colors.green
                                          : Colors.red,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: user.isBlocked
                                      ? const Text(
                                          "Debloquer",
                                        )
                                      : const Text(
                                          "Bloquer",
                                        ),
                                  style: user.isBlocked
                                      ? ElevatedButton.styleFrom(
                                          primary: Colors.greenAccent)
                                      : ElevatedButton.styleFrom(
                                          primary: Colors.orangeAccent),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Supprimer"),
                                          content: Text(
                                              "Etes-vous sur de vouloir supprimer ${user.pseudo} ?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  var block = await model
                                                      .deleteUser(user.id);
                                                  final snackBar = SnackBar(
                                                    content: Text(
                                                      block.value,
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    backgroundColor:
                                                        block.code == 200
                                                            ? Colors.green
                                                            : Colors.red,
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                },
                                                child: const Text("Oui")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Non"))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    "Supprimer",
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.redAccent),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
                .values
                .toList()
        ],
      ),
    );
  }
}
