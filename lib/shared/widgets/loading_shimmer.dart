import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/colors.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    super.key,
    this.height = 16,
    this.width,
    this.borderRadius = 8,
  });

  final double height;
  final double? width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kBorderSubtle,
      highlightColor: kSurfaceCard,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: kSurfaceCard,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
