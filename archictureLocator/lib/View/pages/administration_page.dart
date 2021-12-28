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
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Administration",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[700],
                    width: 5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        child: Text(
                      "Ajouter nouvelle crypto",
                      overflow: TextOverflow.clip,
                    )),
                    const Tooltip(
                      textStyle: TextStyle(fontSize: 16, color: Colors.white),
                      height: 60,
                      message: "Veuillez vous referer  sur Nomics.com",
                      child: Icon(Icons.help),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: TextField(
                      controller: textController,
                    )),
                    const SizedBox(
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
                            style: const TextStyle(fontSize: 20),
                          ),
                          backgroundColor:
                              block.code == 200 ? Colors.green : Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        textController.clear();
                      },
                      child: const Text("Ajout"),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Utilisateurs",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        locator<NavigationService>().navigateTo(RegisterRoute);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Ajouter utilisateur")),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: mWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[700],
                    width: 5,
                  ),
                ),
                child: ViewModelBuilder<UserViewModel>.reactive(
                  viewModelBuilder: () => UserViewModel(),
                  onModelReady: (model) => model.getUsers(),
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
                            "Email Confirmed",
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
                                        child: Icon(
                                          user.EmailIsValidate
                                              ? Icons
                                                  .check_circle_outline_outlined
                                              : Icons
                                                  .remove_circle_outline_outlined,
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
                                                var block = await model
                                                    .blockUser(user.id);
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
                                              child: user.isBlocked
                                                  ? const Text(
                                                      "Debloquer",
                                                    )
                                                  : const Text(
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
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Supprimer"),
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
                                                                  style: const TextStyle(
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
                                                            child: const Text(
                                                                "Oui")),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Non"))
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
                ),
              ),
            ],
          )),
    );
  }
}
