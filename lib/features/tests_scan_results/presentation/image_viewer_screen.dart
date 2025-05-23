import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final List<String> imageUrls;

  const ImageViewerScreen({super.key, required this.imageUrls});

  String _getImagePreviewUrl(String originalUrl) {
    final fileId = RegExp(r'/d/(.*?)/').firstMatch(originalUrl)?.group(1);
    return 'https://drive.google.com/uc?export=view&id=$fileId';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Tests/Scans Results"),
      backgroundColor: ColorsManager.backgroundColor,
      body: PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          final previewUrl = _getImagePreviewUrl(imageUrls[index]);
          return _SingleImageViewer(url: previewUrl);
        },
      ),
    );
  }
}

class _SingleImageViewer extends StatefulWidget {
  final String url;

  const _SingleImageViewer({required this.url});

  @override
  State<_SingleImageViewer> createState() => _SingleImageViewerState();
}

class _SingleImageViewerState extends State<_SingleImageViewer> {
  final TransformationController _transformationController =
      TransformationController();

  bool _isLoading = true;
  bool _isZoomed = false;

  void _handleDoubleTap() {
    setState(() {
      if (_isZoomed) {
        _transformationController.value = Matrix4.identity();
      } else {
        _transformationController.value = Matrix4.identity()..scale(2.5);
      }
      _isZoomed = !_isZoomed;
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          InteractiveViewer(
            transformationController: _transformationController,
            minScale: 1.0,
            maxScale: 5.0,
            child: Center(
              child: Image.network(
                widget.url,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null && _isLoading) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) setState(() => _isLoading = false);
                    });
                  }
                  return child;
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
