import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocare/controllers/video_controller.dart';
import 'package:grocare/utils/video_player_item.dart';

import '../utils/constants.dart';

class VideoPage extends StatefulWidget {
  // final List<Model> list;
  final int index;

  const VideoPage({super.key, this.index = 0});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final pageController = PageController();
  final videoController = Get.find<VideoController>();
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      if (pageController.position.maxScrollExtent == pageController.offset) {
        videoController.getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: (videoController.videoList.length - widget.index) + 1,
          itemBuilder: ((context, i) {
            if (i + widget.index < videoController.videoList.length) {
              return Stack(
                children: [
                  VideoPlayerItem(
                      videoUrl: videoController
                          .videoList[widget.index + i].submission.mediaUrl),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          videoController
                              .videoList[widget.index + i].submission.title,
                          style: kSubtitleTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(videoController
                                  .videoList[widget.index + i].creator.pic),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              videoController
                                  .videoList[widget.index + i].creator.name,
                              style: kSubtitleTextStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: size.height / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: videoController
                                    .videoList[widget.index + i].reaction.voted
                                ? Colors.red
                                : Colors.white,
                            size: 35,
                            shadows: const [
                              Shadow(color: Colors.black, blurRadius: 5.0)
                            ],
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          videoController
                              .videoList[widget.index + i].reaction.count
                              .toString(),
                          style: kSubtitleTextStyle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.comment,
                            color: Colors.white,
                            size: 35,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 5.0)
                            ],
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          videoController
                              .videoList[widget.index + i].comment.count
                              .toString(),
                          style: kSubtitleTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 5,
                      top: 15,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ))
                ],
              );
            } else {
              return Container(
                color: const Color.fromARGB(255, 37, 37, 37),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Loading more data",
                      style: kSubHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          }),
        );
      }),
    );
  }

  @override
  void dispose() {
    videoController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
