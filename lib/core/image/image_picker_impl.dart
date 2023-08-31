// import 'dart:io';
//
// import 'package:flutter/services.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../error/failures.dart';
// import 'image_repository.dart';
//
// class ImagePickerImpl implements ImageRepository{
//
//   final ImagePicker _picker = ImagePicker();
//
//   File? _currentImage;
//
//   List<File> _images = [];
//
//   @override
//   File? get currentImage    => _currentImage;
//
//   List<File> get images => _images;
//
//   void setImages(List<File> images){
//     _images = images;
//   }
//
//
//   @override
//   Future<Either<Failure,File>> pickImage(ImageSourceData source) async {
//     try {
//       final imagePickerSource = source==ImageSourceData.camera ? ImageSource.camera : ImageSource.gallery;
//       final image = await _picker.pickImage(source: imagePickerSource,maxWidth: 1024,maxHeight: 1024);
//       if (image == null) {
//         _currentImage = null;
//         return Left(ImageFailure());
//       }
//
//       _currentImage = File(image.path);
//       return Right(_currentImage!);
//     } on PlatformException {
//       _currentImage = null;
//       return Left(ImageFailure());
//     }
//
//   }
//
//   @override
//   Future<void> pickMultiple() async {
//     try {
//       final imagesX = await _picker.pickMultiImage();
//
//       _images = imagesX.map((e) => File(e.path)).toList();
//     } on PlatformException {
//       rethrow;
//     }
//   }
//
// }