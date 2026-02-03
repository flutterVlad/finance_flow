import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  const ImagePickerService();

  Future<Uint8List?> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    final bytes = await image?.readAsBytes();

    return bytes;
  }
}
