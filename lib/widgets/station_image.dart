import 'package:flutter/material.dart';

class StationImage extends StatelessWidget {
  const StationImage({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        width: 60,
        height: 60,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 60);
        },
        loadingBuilder: (context, child, progress) {
          print('*********');
          print(image);

          return progress == null
              ? child
              : const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
        },
      ),
    );
  }
}
