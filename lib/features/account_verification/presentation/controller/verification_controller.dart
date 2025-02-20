import 'package:camera/camera.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  var selectedGender = "".obs;
  var isChecked = false.obs;
  CameraController? cameraController;
  var isLoading = true.obs;
  var imagePath = "".obs;


  void selectGender(String gender) {
    selectedGender.value = gender;
  }
  Future<void> initializeCamera() async {
    isLoading.value = true;
    try {
      final cameras = await availableCameras();
      cameraController = CameraController(cameras.first, ResolutionPreset.medium);
      await cameraController!.initialize();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Failed to initialize camera: $e");
    }
  }

  Future<void> capturePhoto() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }
    try {
      final image = await cameraController!.takePicture();
      imagePath.value = image.path;
    } catch (e) {
      Get.snackbar("Error", "Failed to capture photo: $e");
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
