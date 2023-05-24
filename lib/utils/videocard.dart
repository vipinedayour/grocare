import 'package:flutter/material.dart';

import '../models/video_model.dart';
import 'constants.dart';

class VideoCard extends StatelessWidget {
  final Model model;
  const VideoCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(8),
      width: 160,
      height: 250,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(model.submission.thumbnail),
          ),
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.submission.title,
            style: kSubtitleTextStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${model.reaction.count} views',
            style: kSubtitleTextStyle,
          ),
        ],
      ),
    );
    //  Container(
    //     margin: const EdgeInsets.all(8),
    //     width: 160,
    //     height: 250,
    //     decoration: BoxDecoration(
    //         color: Colors.grey, borderRadius: BorderRadius.circular(12)),
    //     child: Image(image: NetworkImage(model.submission.thumbnail)));
  }
}
