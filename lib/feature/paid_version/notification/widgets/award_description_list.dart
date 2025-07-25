import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribe365_new/feature/paid_version/notification/controllers/notification_controller.dart';
import 'package:tribe365_new/utill/utility.dart';

class AdAwardDescriptionList extends StatelessWidget {
  const AdAwardDescriptionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationController>(
      builder: (context, provider, _) {
        final items = provider.notificationKudosAwardList;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: items!.length,
          itemBuilder: (context, index) {
            final item = items[index];

            final isSecondLast = index == items.length - 2;

            return Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.description ?? '',
                      style: const TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        Utility.convertDataIntoddMMMyyyyhhmma(item.createdAt!),
                        style: const TextStyle(fontSize: 12, fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                if (!isSecondLast)
                  Container(
                    height: 0.8,
                    color: Colors.white, // border_color
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
