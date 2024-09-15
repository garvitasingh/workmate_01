import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SwimmerForLogs extends StatelessWidget {
  const SwimmerForLogs({super.key});

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
                      const SizedBox(height: 10,),
              ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          height: 50,
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                  itemCount: 12),
            ],
          ),
        ),
      ),
    );
  }
}
