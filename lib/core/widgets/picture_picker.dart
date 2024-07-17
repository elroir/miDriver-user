import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class PicturePicker extends StatelessWidget {

  final String title;
  final bool hasBorders;
  final File? image;
  final void Function() cameraOnPressed;
  final void Function() galleryOnPressed;

  const PicturePicker({super.key, required this.title,  this.image, this.hasBorders=false,required this.cameraOnPressed, required this.galleryOnPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title,style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Container(
          height: 150,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(AppBorder.cardBorderRadius)),
              color: Theme.of(context).colorScheme.surface,
            border: hasBorders ? Border.all() : null
          ),
          child: image==null ? const Icon(Iconsax.image) : ClipRRect(
              borderRadius: BorderRadius.circular(AppBorder.cardBorderRadius),
              child: Image.file(image!,fit: BoxFit.cover)
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed:galleryOnPressed,
                  child: Text(AppStrings.gallery.toUpperCase())
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  onPressed: cameraOnPressed,
                  child: Text(AppStrings.camera.toUpperCase())
              ),
            ),
          ],
        )
      ],
    );
  }
}
