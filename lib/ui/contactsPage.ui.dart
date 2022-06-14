// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:the_zurich_book/ui/components/addEditNameAlert.ui.dart';
import 'package:the_zurich_book/ui/components/contactsList.ui.dart';
import 'package:the_zurich_book/util/gen.util.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // top bar
      appBar: AppBar(
        // title
        title: const Text('Contacts'),
        // back button
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: const ContactsListDisplay(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a New name',
        onPressed: () => popAlert(
          context: context,
          title: 'New Name',
          child: const AddEditNameDialog(),
        ),
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: const SizedBox(height: 50),
      ),
    );
  }
}
