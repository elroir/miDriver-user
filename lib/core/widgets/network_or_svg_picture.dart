import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../http/http_options.dart';

class NetworkOrSvgPicture extends StatelessWidget {
  final String imageUrl;
  final Color? svgColor;
  final double? height;
  final double? width;
  const NetworkOrSvgPicture({Key? key, required this.imageUrl,this.svgColor,this.height,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl,
      httpHeaders: const {'Authorization': HttpOptions.apiToken},
      height: height,
      width: width,
      errorWidget: (_,exception,stackTrace) => SvgPicture.network(
        imageUrl,
        headers: const {'Authorization': HttpOptions.apiToken},
        colorFilter: (svgColor!=null) ? ColorFilter.mode(svgColor!, BlendMode.srcIn) : null,
        height: height,
        width: width,
      ),
    );
  }
}
