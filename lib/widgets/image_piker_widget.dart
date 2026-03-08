
import 'package:flutter/material.dart';

class ImagePiker extends StatelessWidget {
  const ImagePiker({
    super.key, required this.imageName,
  });
  final String? imageName;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: Row(
        children: [
          Container(
            width: 120,
            height: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(16),
              ),

              color: Colors.grey,
            ),
            child: Center(child: Text('Photo',style: TextStyle(fontSize: 18),)),
          ),

          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  imageName ?? "No photo selected",
                  style: const TextStyle(fontSize: 18),
                )
              ),
              ),
            ),
        ],
      ),
    );
  }
}