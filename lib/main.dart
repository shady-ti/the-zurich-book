// TODO: organize imports
// TODO: Export names
// TODO: Error on adding empty names

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:the_zurich_book/ui/contactsPage.ui.dart';
import 'model/vault.model.dart';
import 'ui/components/contactsList.ui.dart';
import 'ui/nameDisplayPage.ui.dart';
import 'util/gen.util.dart';

void main(List<String> args) async {
  setupWindow(title: 'The Zurich Book', windowHeight: 1350, windowWidth: 750);

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
        home: const NameDisplayPage(),
      ),
    ),
  );
}
