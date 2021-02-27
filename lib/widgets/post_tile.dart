import 'package:flutter/material.dart';
import 'package:socialapp/widgets/custom_image.dart';
import 'package:socialapp/widgets/post.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("liking post"),
      child: cachedNetworkImageProvider(post.mediaUrl),
    );
  }
}
