import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class AlbumWidget extends StatelessWidget {
  final imageuri;
  AlbumWidget(this.imageuri);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SpotifySdk.getImage(imageUri: imageuri),
        builder: (ctx, snapshot) {
          return Container(padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 6),
                image: DecorationImage(
                    image:
                        snapshot.connectionState == ConnectionState.waiting ||
                                snapshot.hasError || snapshot.data==null
                            ? AssetImage('assets/images/index.jpeg')
                            : MemoryImage(snapshot.data),
                    fit: BoxFit.cover)),
            width: 300,
            height: 300,
          );
        });
  }
}
