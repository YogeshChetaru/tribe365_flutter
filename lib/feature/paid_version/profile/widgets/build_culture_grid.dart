import 'package:flutter/material.dart';
import '../../../../utill/color_resources.dart';
import '../controllers/profile_controller.dart';

Widget buildCultureGrid(ProfileController profileProvider) {
  return Padding(
    padding: const EdgeInsets.symmetric( vertical: 8),
    child: GridView.builder(
      itemCount: profileProvider.cultureStructureItems!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final item = profileProvider.cultureStructureItems![index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 6,
                offset: const Offset(0, 2),
              )
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorResources.mainColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  item['label']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                item['value']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}