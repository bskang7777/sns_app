import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  /// 카메라 권한 요청
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// 갤러리 권한 요청
  static Future<bool> requestGalleryPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  /// 카메라 권한 확인
  static Future<bool> hasCameraPermission() async {
    return await Permission.camera.isGranted;
  }

  /// 갤러리 권한 확인
  static Future<bool> hasGalleryPermission() async {
    return await Permission.photos.isGranted;
  }

  /// 권한이 거부된 경우 설정으로 이동
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
