// Linking

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:the_zurich_book/model/vault.model.dart';

// Functional

/// Contents of a dialogBox to be displayed when adding or editing names in the [Vault]
///
class AddEditNameDialog extends StatelessWidget {
  final String? existingName;

  const AddEditNameDialog({Key? key, this.existingName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameCheckController = TextEditingController(text: existingName);

    return Consumer<Vault>(
      builder: (context, vault, child) {
        var names = vault.names..sort();

        /// check and pop alert dialog
        ///
        void checkAndSubmit() {
          // Only add and exit if the text field is not empty
          if (nameCheckController.text.trim().isNotEmpty) {
            if (existingName != null) vault.removeName(existingName!);
            vault.addName(nameCheckController.text);
            Navigator.pop(context);
          }
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Get Names
            TextFormField(
              autofocus: true,
              controller: nameCheckController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.characters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (ignoredInput) {
                checkAndSubmit();
              },
              // display nearest existing name and other hints
              validator: (nameToAdd) {
                if (nameToAdd == null || nameToAdd.isEmpty) {
                  return 'PLEASE ENTER A NAME';
                } else if (vault.containsName(nameToAdd)) {
                  return 'NAME ALREADY EXISTS IN VAULT';
                } else {
                  return names.firstWhere(
                    (existingName) => existingName.startsWith(nameToAdd.toUpperCase()),
                    orElse: () => 'NO MATCH, GOOD TO GO',
                  );
                }
              },
              // change the validator output display color
              decoration: InputDecoration(
                errorStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Proceed & Add
                IconButton(
                  onPressed: checkAndSubmit,
                  icon: const Icon(Icons.check_rounded),
                ),
                // Cancel & Ignore
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
