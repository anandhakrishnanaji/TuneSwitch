import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import './lovpop.dart';

class AlbumWidget extends StatelessWidget {
  final imageuri;
  AlbumWidget(this.imageuri);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: SpotifySdk.getImage(
            imageUri: imageuri, dimension: ImageDimension.small),
        builder: (ctx, snapshot) {
          return Stack(alignment: Alignment.center, children: <Widget>[
            Container(
              padding: EdgeInsets.all(0.0487 * width),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 7),
                  image: DecorationImage(
                      image:
                          snapshot.connectionState == ConnectionState.waiting ||
                                  snapshot.hasError ||
                                  snapshot.data == null
                              ? AssetImage('assets/images/index.jpg')
                              : MemoryImage(snapshot.data),
                      fit: BoxFit.cover)),
              width: 0.7292 * width,
              height: 0.7292 * width,
            ),
            LovePop()
          ]);
        });
  }
}
