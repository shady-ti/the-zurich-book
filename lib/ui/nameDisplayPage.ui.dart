// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:the_zurich_book/ui/components/nameDisplay.ui.dart';
import 'package:the_zurich_book/ui/contactsPage.ui.dart';

class NameDisplayPage extends StatelessWidget {
  const NameDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const NameDisplay(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactsPage()),
        ),
        tooltip: 'See & Edit Contacts',
        child: const Icon(Icons.contacts_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: const SizedBox(height: 50),
      ),
    );
  }
}
