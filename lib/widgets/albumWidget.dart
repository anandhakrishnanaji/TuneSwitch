import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:provider/provider.dart';

import '../providers/like.dart';

class AlbumWidget extends StatelessWidget {
  final imageuri;
  AlbumWidget(this.imageuri);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final prov = Provider.of<Like>(context, listen: false);
    if (prov.gotlikes != null)
      Future.delayed(Duration(seconds: 5))
          .then((value) => prov.setgotlikes(null));
    return FutureBuilder(
        future: SpotifySdk.getImage(
            imageUri: imageuri, dimension: ImageDimension.small),
        builder: (ctx, snapshot) {
          return Consumer<Like>(
            builder: (context, value, child) => Stack(children: <Widget>[
              value.gotlikes != null
                  ? Stack(children: [
                      Text(value.gotlikes),
                      Image.asset(
                        'images/assets/lovpop.gif',
                        height: 0.7292 * width,
                        width: 0.7292 * width,
                      )
                    ])
                  : SizedBox(),
              Container(
                padding: EdgeInsets.all(0.0487 * width),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 7),
                    image: DecorationImage(
                        image: snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.hasError ||
                                snapshot.data == null
                            ? AssetImage('assets/images/index.jpg')
                            : MemoryImage(snapshot.data),
                        fit: BoxFit.cover)),
                width: 0.7292 * width,
                height: 0.7292 * width,
              ),
            ]),
          );
        });
  }
}
