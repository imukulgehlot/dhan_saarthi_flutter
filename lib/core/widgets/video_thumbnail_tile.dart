// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
//
// import '../basic_features.dart';
//
// class VideoThumbnailTile extends StatefulWidget {
//   final String videoURL;
//   final double? width;
//   final double? height;
//   final double? radius;
//
//   const VideoThumbnailTile(
//       {super.key,
//       required this.videoURL,
//       this.width,
//       this.height,
//       this.radius});
//
//   @override
//   State<VideoThumbnailTile> createState() => _VideoThumbnailTileState();
// }
//
// class _VideoThumbnailTileState extends State<VideoThumbnailTile> {
//   String thumbnailPath = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return thumbnailPath.isEmpty
//         ? FutureBuilder(
//             future: AppUtils.genThumbnailFile(widget.videoURL),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius:
//                         BorderRadius.circular(widget.radius ?? Dimensions.r10),
//                   ),
//                   width: widget.width ?? Dimensions.w80,
//                   height: widget.height ?? Dimensions.w80,
//                   child: const Center(
//                     child: CupertinoActivityIndicator(
//                       color: ColorConst.primaryColor,
//                     ),
//                   ),
//                 );
//               } else if (snapshot.hasData) {
//                 thumbnailPath = snapshot.data!;
//
//                 return ClipRRect(
//                   borderRadius:
//                       BorderRadius.circular(widget.radius ?? Dimensions.r10),
//                   child: Image.file(
//                     File(snapshot.data!),
//                     width: widget.width ?? Dimensions.w80,
//                     height: widget.height ?? Dimensions.w80,
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               } else {
//                 return const SizedBox();
//               }
//             },
//           )
//         : ClipRRect(
//             borderRadius:
//                 BorderRadius.circular(widget.radius ?? Dimensions.r10),
//             child: Image.file(
//               File(thumbnailPath),
//               width: widget.width ?? Dimensions.w80,
//               height: widget.height ?? Dimensions.w80,
//               fit: BoxFit.cover,
//             ),
//           );
//   }
// }
