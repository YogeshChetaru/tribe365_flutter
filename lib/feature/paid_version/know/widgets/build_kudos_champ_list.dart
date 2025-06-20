import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/images.dart';
import '../controllers/know_controller.dart';

class BuildKudosChampList extends StatelessWidget {

 final KnowController knowProvider;
  const BuildKudosChampList({super.key,required this.knowProvider});

  @override
  Widget build(BuildContext context) {
    if (knowProvider.lastMonthKudosChamp != null &&
        knowProvider.lastMonthKudosChamp!.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: knowProvider.lastMonthKudosChamp!.length,
        itemBuilder: (context, index) {
          final item = knowProvider.lastMonthKudosChamp![index];
          final isTop = index == 0;
          final isLast = index == knowProvider.lastMonthKudosChamp!.length - 1;
          return  Column(
            children: [
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isTop ? Colors.red : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: item.userImage ?? '',
                      placeholder: (context, url) => const CircleAvatar(
                        backgroundImage: AssetImage(Images.imgUserCircleGray),
                      ),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        backgroundImage: AssetImage(Images.imgUserCircleGray),
                      ),
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  item.userName ?? '',
                  style: TextStyle(
                    color: isTop ? Colors.red : Colors.black,
                  ),
                ),
                subtitle: Text(
                  item.count.toString(),
                  style: TextStyle(
                    color: isTop ? Colors.red : Colors.black,
                  ),
                ),
                trailing: isTop
                    ? const Icon(Icons.emoji_events, color: Colors.red) // Crown image substitute
                    : null,
              ),

              // Bottom Divider (shown unless it's the last item)
              if (!isLast)
                const Divider(
                  height: 1,
                  color: Colors.grey,
                  indent: 72, // aligns after avatar
                ),
            ],
          );
        },
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Text(
            getTranslated("no_kudos_champ_yet", context)!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          ),
        ),
      );
    }
  }
}
