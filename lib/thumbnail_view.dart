import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewThumbnailView extends StatefulWidget {
  Image image;
  ViewThumbnailView({required this.image, super.key});

  @override
  State<ViewThumbnailView> createState() => _ViewThumbnailViewState();
}

class _ViewThumbnailViewState extends State<ViewThumbnailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: widget.image),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('戻る'),
          ),
        ]),
      ),
    );
  }
}
