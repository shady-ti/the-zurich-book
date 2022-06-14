// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../model/vault.model.dart';

class NameDisplay extends StatelessWidget {
  const NameDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Vault>(
      builder: (context, vault, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(vault.cName, style: const TextStyle(fontSize: 27)),
            ),
          ),
          onTap: () {
            vault.nextName();
          },
        );
      },
    );
  }
}
