import 'package:image_picker/image_picker.dart';

class FolderControl {
  final picker = ImagePicker();

  Future<String> getVideoPath() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? videoFile =
          await _picker.pickVideo(source: ImageSource.gallery);
      if (videoFile != null) {
        return Future<String>.value(videoFile.path);
      } else {
        // ignore: avoid_print
        print('No video selected');
        return Future<String>.value('');
      }
    } catch (e) {
      // ignore: avoid_print
      print('e:${e.toString()}');
      return Future<String>.value('');
    }
  }
}
