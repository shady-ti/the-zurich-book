import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/vault.model.dart';

class ContactsListDisplay extends StatelessWidget {
  const ContactsListDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Vault>(
      builder: (context, vault, child) {
        var names = vault.names..sort();

        return ListView.separated(
          itemCount: names.length,
          itemBuilder: (context, index) {
            var name = names.elementAt(index);

            return ListTile(
              title: Text(name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        var nameController = TextEditingController(text: name);

                        return AlertDialog(
                          title: const Text('New Name'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                autofocus: true,
                                controller: nameController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (nameToAdd) {
                                  if (nameToAdd == null || nameToAdd.trim().isEmpty) {
                                    return 'Please enter a name';
                                  } else if (vault.containsName(nameToAdd)) {
                                    return 'Name already exists in the vault';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      vault.removeName(name);
                                      vault.addName(nameController.text);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.check_rounded),
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(Icons.close_rounded),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    icon: const Icon(Icons.edit_rounded),
                  ),
                  IconButton(
                    onPressed: () => vault.removeName(name),
                    icon: const Icon(Icons.delete_rounded),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      },
    );
  }
}
