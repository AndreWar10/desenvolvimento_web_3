import 'dart:io';
import 'package:example_10_09/core/utils/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class UploadProductController extends ChangeNotifier {
  UploadProductController();

  File? image;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final stockController = TextEditingController();

  bool loading = false;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> uploadProduct(Function messageFunc) async {
    if (image == null) return;

    setLoading(true);

    final uri = Uri.parse('http://${Environment.ip}:3001/upload-product'); // Backend URL
    final mimeTypeData = lookupMimeType(image!.path)!.split('/'); // Get MIME type

    try {
        final request = http.MultipartRequest('POST', uri)
          ..fields['name'] = nameController.text
          ..fields['description'] = descriptionController.text
          ..fields['price'] = priceController.text
          ..fields['category'] = categoryController.text
          ..fields['stock'] = stockController.text
          ..files.add(
            await http.MultipartFile.fromPath(
              'image',
              image!.path,
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
            ),
          );

        final response = await request.send();

        if (response.statusCode == 200) {
            setLoading(false);
            debugPrint('Product uploaded successfully!');
            messageFunc(true, 'Produto criado com sucesso!');
            clear();
        } else {
            setLoading(false);
            debugPrint('Product upload failed with status code: ${response.statusCode}');
            messageFunc(false, 'Erro ao criar produto!');
        }
    } catch (e) {
        debugPrint('Error during upload: $e');
        setLoading(false);
        messageFunc(false, 'Erro ao criar produto!');
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    notifyListeners();
  }

  void clear() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    categoryController.clear();
    stockController.clear();
    image = null;
  }
}