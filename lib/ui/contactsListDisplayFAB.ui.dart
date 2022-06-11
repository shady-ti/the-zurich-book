import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/vault.model.dart';

class ContactsListDisplayFAB extends StatelessWidget {
  const ContactsListDisplayFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Vault>(
      builder: (context, vault, child) => FloatingActionButton(
        tooltip: 'Add a New name',
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false, // make un-dismissible by tapping outside of the alert
            builder: (context) {
              var nameController = TextEditingController();

              return AlertDialog(
                title: const Text('New Name'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      autofocus: true,
                      controller: nameController,
                      keyboardType: TextInputType.name,
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

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
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
          );
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
