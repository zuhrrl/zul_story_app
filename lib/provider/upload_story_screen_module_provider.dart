import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zul_story_app/constant/result_state.dart';
import 'package:zul_story_app/data/model/add_story.dart';
import 'package:image/image.dart' as img;
import 'package:zul_story_app/main.dart';

class UploadStoryScreenModuleProvider extends ChangeNotifier {
  var _photo;
  late ResultState _state;
  bool _isUploading = false;
  bool _isCompressing = false;
  String _uploadStatus = 'Compressing...';

  String storyDescription = '';

  ResultState get state => _state;

  setSelectedPhoto(value) {
    _photo = value;
    notifyListeners();
  }

  setStoryDescription(value) {
    storyDescription = value;
    notifyListeners();
  }

  get isUploading => _isUploading;

  get isCompressing => _isCompressing;

  get uploadStatus => _uploadStatus;

  get getSelectedPhoto => _photo;
  getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? cameraPhoto =
        await picker.pickImage(source: ImageSource.camera);
    _photo = cameraPhoto;
    notifyListeners();
  }

  getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? cameraPhoto =
        await picker.pickImage(source: ImageSource.gallery);
    _photo = cameraPhoto;
    notifyListeners();
  }

  uploadStory() async {
    _state = ResultState.loading;
    _isUploading = true;
    notifyListeners();
    try {
      await Future.delayed(const Duration(seconds: 1), () async {
        final compressedImage =
            await compressImage(File(_photo!.path).readAsBytesSync());

        var selectedFile = File(_photo!.path);
        var fileName = selectedFile.path.split('/').last;
        var upload = await apiService.uploadStory(compressedImage, fileName,
            storyDescription, compressedImage.length);
        var addStory = AddStory.fromJson(upload);

        if (addStory.error) {
          _state = ResultState.error;
        }

        _state = ResultState.uploadSuccess;
        _photo = null;
        notifyListeners();
        print(addStory.message);
      });
    } catch (err, stack) {
      print(stack);
    }
  }

  Future<List<int>> compressImage(Uint8List bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
      _isCompressing = true;
      _uploadStatus = 'Compressing image...';
    } while (length > 1000000);
    return newByte;
  }
}
