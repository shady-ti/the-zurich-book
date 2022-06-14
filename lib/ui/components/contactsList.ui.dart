// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:the_zurich_book/model/vault.model.dart';
import 'package:the_zurich_book/ui/components/addEditNameAlert.ui.dart';
import 'package:the_zurich_book/util/gen.util.dart';

class ContactsListDisplay extends StatelessWidget {
  const ContactsListDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Vault>(
      builder: (context, vault, child) {
        var names = vault.names..sort();

        // List
        return ListView.separated(
          itemCount: names.length,
          itemBuilder: (context, index) {
            var name = names.elementAt(index);

            // List Tile
            return ListTile(
              // Name
              title: Text(name),
              // Actions
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit button
                  Tooltip(
                    message: 'Edit this name',
                    child: IconButton(
                      onPressed: () => popAlert(
                        context: context,
                        title: 'Edit Name',
                        child: AddEditNameDialog(
                          existingName: name,
                        ),
                      ),
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  // Hold to delete button
                  Tooltip(
                    message: 'Hold to delete this name',
                    child: GestureDetector(
                      onLongPress: () => vault.removeName(name),
                      child: Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
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
