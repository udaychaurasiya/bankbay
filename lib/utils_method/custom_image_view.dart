import 'package:bank_bay/style/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class CustomImageView extends StatefulWidget {
  final String imageUrls;
  const CustomImageView({super.key, required this.imageUrls});

  @override
  State<CustomImageView> createState() => _CustomImageViewState();
}

class _CustomImageViewState extends State<CustomImageView> {
  double? _progress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 10.0.r),
          child: IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.close_outlined, size: 28.r, color: AllColors.red,)),
        ),
        backgroundColor: AllColors.none,
        elevation: 0,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(
            widget.imageUrls.toString(),
          ),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AllColors.white.withOpacity(0.15),
        onPressed: (){
          FileDownloader.downloadFile(
              url: widget.imageUrls,
              onProgress: (name, progress) {
                setState(() {
                  _progress = progress;
                });
              },
              onDownloadCompleted: (value) {
                print('path  $value ');
                setState(() {
                  _progress = null;
                });
              });
        },
        child: _progress != null
            ? const CircularProgressIndicator()
            : Icon(Icons.download, size: 26.r),
      ),
    );
  }
}
