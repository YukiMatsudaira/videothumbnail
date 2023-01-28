import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class MakeThumbnail {
  Future<String> getThumbnailTwo(String videopath, int position) async {
    try {
      final thumbnailFile = await VideoThumbnail.thumbnailFile(
        video: videopath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        timeMs: position,
      );

      // ignore: unnecessary_null_comparison
      if (thumbnailFile != null) {
        return Future<String>.value(thumbnailFile);
      } else {
        return Future<String>.value('');
      }
    } catch (e) {
      return Future<String>.value('');
    }
  }
}
