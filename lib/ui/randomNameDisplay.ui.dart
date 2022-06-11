import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/vault.model.dart';

class RandomNameDisplay extends StatelessWidget {
  const RandomNameDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Vault>(
      builder: (context, vault, child) {
        return GestureDetector(
          child: Center(child: Text(vault.cName, style: const TextStyle(fontSize: 27))),
          onTap: () {
            vault.nextName();
          },
        );
      },
    );
  }
}
