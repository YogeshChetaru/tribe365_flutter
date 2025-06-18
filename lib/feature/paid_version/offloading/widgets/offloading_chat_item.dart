import 'package:flutter/material.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/color_resources.dart';

import '../../../../utill/dimensions.dart';
import '../../../../utill/utility.dart';
import '../domain/models/view_message_details_response.dart';
import '../domain/models/view_offloading_list_response.dart';
import '../screens/offloading_chat_details_screen.dart';

class OffloadingChatItem extends StatelessWidget {
  final Messages data;

  const OffloadingChatItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isAdmin = data.userType == 'Admin';
    final hasImage = data.msgImageUrl != null && data.msgImageUrl!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Align(
        alignment: isAdmin ? Alignment.centerLeft : Alignment.centerRight,
        child: Column(
          crossAxisAlignment:
          isAdmin ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            if (isAdmin)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  data.name ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.65,
              ),
              decoration: BoxDecoration(
                color: hasImage
                    ? Colors.transparent
                    : (isAdmin ? Colors.grey[300] : ColorResources.mainColor),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft:
                  isAdmin ? const Radius.circular(0) : const Radius.circular(10),
                  bottomRight:
                  isAdmin ? const Radius.circular(10) : const Radius.circular(0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (hasImage)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        data.msgImageUrl!,
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Text(
                        data.message ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: isAdmin ? Colors.black : ColorResources.white,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 6,
                    ),
                    child: Text(
                      Utility.convertDataIntoddMMMyyyyhhmma(data.createdAt ?? ''),
                      style: TextStyle(
                        fontSize: 10,
                        color: isAdmin ? Colors.black54 : Colors.white70,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
