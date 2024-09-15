import 'package:flutter/material.dart';
import 'package:namer/main.dart';
import 'package:namer/widgets/big_card.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    String pair = appState.current.asLowerCase;

    IconData? icon;
    if (appState.favorites.contains(appState.current)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_outline;
    }

    String hashed = md5.convert(pair.codeUnits).toString();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image-placeholder.png"),
                ),
              ),
              child: Image.network(
                height: 250,
                width: 250,
                'https://gravatar.com/avatar/$hashed?s=256&d=retro',
              ),
            ),
            BigCard(pair: pair),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: appState.toggleFavorite,
                  label: Text("Favorite"),
                  icon: Icon(icon),
                ),
                SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                    onPressed: appState.getNext, child: Text("Next")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
