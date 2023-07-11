// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../../../core/resources/strings_manager.dart';
// import '../../../../core/resources/values_manager.dart';
// import '../../../../core/widgets/picture_picker.dart';
// import '../provider/personal_data_provider.dart';
//
// class ProfilePicturePicker extends StatelessWidget {
//   const ProfilePicturePicker({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: MediaQuery.of(context).size.width >= 380
//           ? const _BigScreenWidget()
//           : const _SmallScreenWidget(),
//     );
//   }
// }
//
// class _BigScreenWidget extends ConsumerWidget {
//   const _BigScreenWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context,ref) {
//     final imageProvider = ref.watch(personalDataProvider);
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 3,
//           child: Padding(
//             padding: const EdgeInsets.only(right: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(AppStrings.profilePicture,style: Theme.of(context).textTheme.titleLarge),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () => imageProvider.pickProfilePictureFromGallery(),
//                   child: Text(AppStrings.gallery.toUpperCase())
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                     onPressed: () => imageProvider.pickProfilePictureFromCamera(),
//                     child: Text(AppStrings.camera.toUpperCase())
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 2,
//           child: Container(
//             height: 144,
//             width: 220,
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(AppBorder.cardBorderRadius)),
//               color: Theme.of(context).colorScheme.background
//             ),
//             child: imageProvider.profilePicture==null ? const Icon(Iconsax.image) : ClipRRect(
//               borderRadius: BorderRadius.circular(AppBorder.cardBorderRadius),
//               child: Image.file(imageProvider.profilePicture!,fit: BoxFit.cover)
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class _SmallScreenWidget extends ConsumerWidget {
//   const _SmallScreenWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context,ref) {
//     final imageProvider = ref.watch(personalDataProvider);
//
//     return PicturePicker(
//         title: AppStrings.profilePicture,
//         image:  imageProvider.profilePicture,
//         cameraOnPressed: () => imageProvider.pickProfilePictureFromCamera(),
//         galleryOnPressed: () => imageProvider.pickProfilePictureFromGallery()
//     );
//   }
// }
//

