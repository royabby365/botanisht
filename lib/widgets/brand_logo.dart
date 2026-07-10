import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Brand wordmark for Botanisht.
///
/// Renders the site's official logo asset (`assets/data/logo.svg`) — a
/// self-contained 64×64 mark (green rounded tile with a white leaf). Because
/// the SVG already carries its own green background and transparent padding,
/// it needs no white-background knockout and reads correctly on both the
/// cream and evergreen app bars as well as the splash screen.
///
/// The mark is square, so when only one dimension is supplied the other is
/// derived to keep it 1:1; with no size it defaults to the 40px app-bar size.
class BrandLogo extends StatelessWidget {
  final double? height;
  final double? width;

  const BrandLogo({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    if (height != null && width != null) {
      return SvgPicture.asset('assets/data/logo.svg', width: width, height: height);
    }
    if (height != null) {
      return SvgPicture.asset('assets/data/logo.svg', width: height, height: height);
    }
    if (width != null) {
      return SvgPicture.asset('assets/data/logo.svg', width: width, height: width);
    }
    return SvgPicture.asset('assets/data/logo.svg', width: 40, height: 40);
  }
}
