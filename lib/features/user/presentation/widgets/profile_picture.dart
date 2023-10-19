
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/http/http_options.dart';
import '../../../../core/resources/values_manager.dart';
import '../../domain/entities/user.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.4,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.black87,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppBorder.cardMaxBorderRadius)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.height*0.12,
              foregroundImage: CachedNetworkImageProvider(user.imageUrl,
                  headers: const {'Authorization' : HttpOptions.apiToken}
              ),
            ),
            Text('${user.name} ${user.lastName}',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white))
          ],
        ),
      ),
    );
  }
}