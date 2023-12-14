import 'dart:io';

//cliper 적용예정
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

class AddImage extends StatefulWidget {
  const AddImage(this.addImageFunc, {Key? key}) : super(key: key);

  final Function(File pickedImage) addImageFunc;

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  // File? pickedImage;
  // Future _pickImage() async {
  //   final imagePicker = ImagePicker();
  //   var pickedImageFile = await imagePicker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 50,
  //     maxHeight: 150,
  //   );
  //   if (pickedImageFile != null) {
  //     setState(() {
  //       pickedImage = File(pickedImageFile.path);
  //       widget.addImageFunc(pickedImage!);
  //     });
  //   }
  // }
  File? _image;
  final picker = ImagePicker();
  bool imageCheck = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        maxWidth: 700,
        maxHeight: 700,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        aspectRatioPresets: const [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 70,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
      );

      if (croppedFile != null) {
        _image = await convertCroppedFileToFile(croppedFile);
        imageCheck = true;
        setState(() {
          _image = _image;
          widget.addImageFunc(_image!);
        });
      }
    }
  }

  Future<File> convertCroppedFileToFile(CroppedFile croppedFile) async {
    final tempDir = await getTemporaryDirectory();
    final uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final File tempFile = File('${tempDir.path}/$uniqueFileName.jpg');

    // Get the cropped image file as bytes
    final croppedBytes = await croppedFile.readAsBytes();

    // Write the cropped image bytes to the new file
    await tempFile.writeAsBytes(croppedBytes);

    return tempFile;
  }

  String userName = "";
  String userEmail = "";
  String userPw = "";

  void pickImage(File image) {
    _image = image;
    widget.addImageFunc(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: 150,
      height: 300,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            backgroundImage: _image != null ? FileImage(_image!) : null,
          ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton.icon(
              onPressed: () {
                _pickImage();
              },
              icon: const Icon(Icons.image),
              label: const Text("프사 추가")),
          const SizedBox(
            height: 80,
          ),
          TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
              label: const Text('종료'))
        ],
      ),
    );
  }
}
