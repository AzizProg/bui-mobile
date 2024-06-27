import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';
import 'package:test_mobile/src/shared/constants/app_images.dart';
import 'package:test_mobile/src/shared/extension/size_extension.dart';

class OthersServices extends StatelessWidget {
  const OthersServices({required this.servicesItems, super.key});
  final List<String> servicesItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      height: context.screenHeight / 6,
      width: context.screenWidth,
      padding: EdgeInsets.all(context.setWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                AppImages.logoLight,
                width: 40,
              ),
              SizedBox(
                width: context.setWidth(5),
              ),
              Text(
                'Pay',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
          Expanded(
            child: PageView.builder(
              itemCount: servicesItems.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    servicesItems[index],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
