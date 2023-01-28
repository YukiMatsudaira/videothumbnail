import 'package:flutter/material.dart';
import 'package:videoselect/control/folder_control.dart';
import 'package:videoselect/video.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  String videoPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: videoPath.isEmpty
                ? const Center(child: Text('動画を選択してください'))
                : Video(videoPath: videoPath)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    videoPath = '';
                  });
                  FolderControl().getVideoPath().then((path) => {
                        setState(() {
                          videoPath = path;
                        })
                      });
                },
                child: const Text('動画を選択'),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
