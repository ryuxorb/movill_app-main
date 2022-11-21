import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//Type1 : 알림 페이지 Type2 : 마이 페이지
enum AvatarType { Type1, Type2 }

class AvatarWidget extends StatelessWidget {
  String thumbPath;
  String? nickname;
  AvatarType type;
  double? size;

  AvatarWidget({
    Key? key,
    required this.type,
    required this.thumbPath,
    this.nickname,
    this.size = 100,
  }) : super(key: key);

  Widget type1Widget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size!),
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: SizedBox(
          width: size,
          height: size,
          child: CachedNetworkImage(
            imageUrl: thumbPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.Type1:
        return type1Widget();
        break;
      case AvatarType.Type2:
        return Container();
        break;
    }
  }
}
