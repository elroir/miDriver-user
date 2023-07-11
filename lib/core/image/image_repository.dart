import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

enum ImageSourceData{
  gallery,
  camera
}

abstract interface class ImageRepository{

  File? get currentImage;

  Future<Either<Failure,File>> pickImage(ImageSourceData source);

  Future<void> pickMultiple();

}