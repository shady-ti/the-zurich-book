// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:get_storage/get_storage.dart';

class ExistingNameException implements Exception {
  String message;

  ExistingNameException(this.message);

  @override
  String toString() {
    return 'ExistingNameException:  $message';
  }
}

/// stores names and provides supporting functionality
///
/// ### Note
/// - [GetStorage] has to be initialized (`await GetStorage.init()`) before this class can be used.
///
class Vault extends ChangeNotifier {
  /// names yet to be served up
  ///
  var _nameSet1 = <String>[];

  /// names that have been served up
  ///
  var _nameSet2 = <String>[];

  var _cName = 'Tap for next name';

  final _randomEngine = Random();

  final store = GetStorage('vault');

  Vault() {
    try {
      _cName = store.read<String>('cName')!;
      _nameSet1 = store.read<List>('N1')!.cast();
      _nameSet2 = store.read<List>('N2')!.cast();
    } catch (e) {
      _cName = 'Please head to the contacts page\nand add names first';
    }

    if (_nameSet1.isEmpty && _nameSet2.isEmpty) {
      _cName = 'Please head to the contacts page and add names first';
    }
  }

  /// all names in the vault
  ///
  List<String> get names => _nameSet1 + _nameSet2;

  String get cName => _cName;

  /// add a name to the vault
  ///
  /// ### Errors
  /// - `ExistingNameException` when trying to add a name that is already in the vault
  ///
  void addName(String name) {
    if (containsName(name)) {
      throw ExistingNameException('$name already exists in the vault');
    } else {
      _nameSet1.add(name.toUpperCase());
    }

    save();

    notifyListeners();
  }

  /// check if the vault contains a given name
  bool containsName(String name) =>
      _nameSet1.contains(name.toUpperCase()) ||
      _nameSet2.contains(name.toUpperCase());

  /// remove a name from the vault
  ///
  void removeName(String name) {
    if (!_nameSet1.remove(name)) {
      _nameSet2.remove(name);
    }

    save();

    notifyListeners();
  }

  /// moves cName to the next name
  ///
  /// ### Note
  /// - the vault keeps track of names served up, so, you will not get repeat names until all names
  /// in the vault have been served up at least once.
  ///
  void nextName() {
    if (_nameSet1.isEmpty) {
      _nameSet1 = _nameSet2;
      _nameSet2 = <String>[];
    }

    var nameIndex = _randomEngine.nextInt(_nameSet1.length);
    _cName = _nameSet1.elementAt(nameIndex);

    _nameSet2.add(_cName);
    _nameSet1.remove(_cName);

    save();

    notifyListeners();
  }

  Future<void> save() async {
    await store.write('N1', _nameSet1);
    await store.write('N2', _nameSet2);
    await store.write('cName', _cName);
  }
}
