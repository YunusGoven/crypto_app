import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/ViewModel/user_viewmodel.dart';
import 'package:mvvm/locator.dart';
import 'package:stacked/stacked.dart';

class AdministrationPage extends StatefulWidget {
  const AdministrationPage({Key key}) : super(key: key);

  @override
  _AdministrationPageState createState() => _AdministrationPageState();
}

class _AdministrationPageState extends State<AdministrationPage> {
  final textController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Administration",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      "Ajouter nouvelle crypto",
                      overflow: TextOverflow.clip,
                    )),
                    Tooltip(
                      textStyle: TextStyle(fontSize: 16, color: Colors.white),
                      height: 60,
                      message: "Drere va sur Nomics.com",
                      child: Icon(Icons.help),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: mWidth * 0.3,
                        child: Expanded(
                            child: TextField(
                          controller: textController,
                        ))),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var text = textController.text.toUpperCase();
                        var block =
                            await locator<ApiService>().addNewCrypto(text);
                        final snackBar = SnackBar(
                          content: Text(
                            block.value,
                            style: TextStyle(fontSize: 20),
                          ),
                          backgroundColor:
                              block.code == 200 ? Colors.green : Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        textController.clear();
                      },
                      child: Text("Ajout"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Utilisateurs",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        locator<NavigationService>().navigateTo(RegisterRoute);
                      },
                      icon: Icon(Icons.add),
                      label: Text("Ajouter utilisateur")),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                width: mWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                child: ViewModelBuilder<UserViewModel>.reactive(
                  viewModelBuilder: () => UserViewModel(),
                  onModelReady: (model) => model.getUsers(),
                  builder: (context, model, child) => Table(
                    border: TableBorder.all(),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FlexColumnWidth(.75),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(.45),
                      3: FlexColumnWidth(.45)
                    },
                    children: [
                      TableRow(children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              "UserName",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Solde",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Action",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
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
                                        child: Text("${user.solde} \$"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                var block = await model
                                                    .blockUser(user.id);
                                                final snackBar = SnackBar(
                                                  content: Text(
                                                    block.value,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  backgroundColor:
                                                      block.code == 200
                                                          ? Colors.green
                                                          : Colors.red,
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              },
                                              child: user.isBlocked
                                                  ? Text(
                                                      "Debloquer",
                                                    )
                                                  : Text(
                                                      "Bloquer",
                                                    ),
                                              style: user.isBlocked
                                                  ? ElevatedButton.styleFrom(
                                                      primary:
                                                          Colors.greenAccent)
                                                  : ElevatedButton.styleFrom(
                                                      primary:
                                                          Colors.orangeAccent),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text("Supprimer"),
                                                      content: Text(
                                                          "Etes-vous sur de vouloir supprimer ${user.pseudo} ?"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              var block = await model
                                                                  .deleteUser(
                                                                      user.id);
                                                              final snackBar =
                                                                  SnackBar(
                                                                content: Text(
                                                                  block.value,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                backgroundColor:
                                                                    block.code == 200
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red,
                                                              );
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            },
                                                            child: Text("Oui")),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text("Non"))
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
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
                ),
              ),
            ],
          )),
    );
  }
}
