import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SwimmerForVisitView extends StatelessWidget {
  const SwimmerForVisitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  height: 150,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  height: 150,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  height: 150,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  height: 150,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  height: 150,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  height: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
