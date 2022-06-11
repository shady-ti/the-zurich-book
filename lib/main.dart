// TODO: organize imports
// TODO: Export names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

import 'model/vault.model.dart';
import 'ui/contactsListDisplay.ui.dart';
import 'ui/contactsListDisplayFAB.ui.dart';
import 'ui/randomNameDisplay.ui.dart';
import 'util/gen.util.dart';

void main(List<String> args) async {
  setupWindow(title: 'The Zurich Book', windowHeight: 1000, windowWidth: 750);

  await GetStorage.init('vault');

  runApp(
    ChangeNotifierProvider(
      create: (context) => Vault(),
      child: MaterialApp(
        darkTheme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lime,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.dark,
        home: const HomePage(),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RandomNameDisplay(),
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

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: const ContactsListDisplay(),
      floatingActionButton: const ContactsListDisplayFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: const SizedBox(height: 50),
      ),
    );
  }
}
