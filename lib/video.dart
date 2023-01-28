import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:videoselect/control/makethumbnail.dart';
import 'package:videoselect/thumbnail_view.dart';

// ignore: must_be_immutable
class Video extends StatefulWidget {
  String videoPath;
  Video({super.key, required this.videoPath});

  @override
  State<Video> createState() => VideoState();
}

class VideoState extends State<Video> {
  late VideoPlayerController controller;
  late ChewieController chewieController;
  late File file;
  late Uint8List bytes;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(File(widget.videoPath));
    chewieController = ChewieController(
      videoPlayerController: controller,
      aspectRatio: 0.5625,
      allowFullScreen: false,
      allowMuting: false,
    );

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Chewie(controller: chewieController),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[800],
              ),
              onPressed: () {
                int timeMs = 0;
                // ボタンが押されたときのシークバーの位置をミリ秒に変換
                controller.value.position
                    .toString()
                    .split(':')
                    .asMap()
                    .forEach((key, value) {
                  if (key == 0) {
                    timeMs += (int.parse(value) * 60 * 60) * 1000;
                  } else if (key == 1) {
                    timeMs += (int.parse(value) * 60) * 1000;
                  } else {
                    timeMs += (double.parse(value) * 1000).toInt();
                  }
                });

                // 生成したサムネイルの表示
                MakeThumbnail()
                    .getThumbnailTwo(widget.videoPath, timeMs)
                    .then((path) => {
                          file = File(path),
                          bytes = file.readAsBytesSync(),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewThumbnailView(
                                      image: Image.memory(bytes)))),
                        });
              },
              child: const Text('サムネイル取得'),
            ),
          ),
        ),
      ],
    );
  }
}
