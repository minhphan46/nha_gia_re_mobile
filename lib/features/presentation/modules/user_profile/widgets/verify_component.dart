import 'package:flutter/widgets.dart';

import '../../../../../config/values/asset_image.dart';

class VerifyComponent extends StatelessWidget {
  const VerifyComponent({
    required this.isVerify,
    required this.isMe,
    super.key,
  });

  final bool isVerify;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.badge,
      width: 20,
      height: 20,
    );
  }
}
