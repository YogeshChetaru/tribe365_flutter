import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_route.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controllers/profile_controller.dart';
import '../domain/models/view_action_list_response.dart';
import '../screens/profile_actions_comments_screen.dart';
import '../screens/profile_add_actions_screen.dart';
import 'actiondeletedialog.dart';

Widget buildActionItem(BuildContext context, ViewActionListData item, String sessionUserId) {
  // Determine status
  String statusText = getTranslated("not_started", context)!;
  Color statusColor = ColorResources.colorED1C24;
  if (item.orgStatus?.toLowerCase() == "started") {
    statusText = getTranslated("started", context)!;
    statusColor = ColorResources.colorF6941D;
  } else if (item.orgStatus?.toLowerCase() == "completed") {
    statusText = getTranslated("completed", context)!;
    statusColor = ColorResources.color39B54A;
  }

  // Determine tier badge
  bool showTier = !(["department", "office", "individual"].contains(item.tier?.toLowerCase() ?? ""));
  Color tierColor = Colors.grey;
  if (item.tier?.toLowerCase() == "primary") {
    tierColor = ColorResources.color97d5a1;
  } else if (item.tier?.toLowerCase() == "secondary") {
    tierColor = ColorResources.color9ec9e1;
  } else if (item.tier?.toLowerCase() == "tertiary") {
    tierColor = ColorResources.colorf5cdd1;
  }

  // Themes
  String themesText = "";
  if (item.themes != null && item.themes!.isNotEmpty) {
    themesText = item.themes!.map((e) => e.title).join(", ");
  }

  return Slidable(
    startActionPane: ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (_) {
            routePush(context, ProfileAddActionsScreen());
          },
          backgroundColor: ColorResources.mainColor,
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: getTranslated("edit", context)!,
        ),
      ],
    ),
    endActionPane: ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (_) {
            customShowDialog(context, ActionDeleteDialog(data: item));
          },
          backgroundColor: ColorResources.mainColor,
          foregroundColor: ColorResources.white,
          icon: Icons.delete,
          label: getTranslated("delete", context)!,
        ),
      ],
    ),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey.shade300,
                child: Icon(Icons.person, size: 14, color: Colors.grey),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.name ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (showTier)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: tierColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item.tier ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  routePush(context, ProfileActionsCommentsScreen());
                },
                child: Image.asset(
                  Images.imgCommentRed,
                  width: 24,
                  height: 24,
                ),
              )
            ],
          ),
          const SizedBox(height: 6),
          if ((item.description ?? "").isNotEmpty)
            Text(
              item.description ?? "",
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey.shade300, height: 1),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  flex: 30,
                  child: Text("${getTranslated("start_date", context)!}:",
                      style: TextStyle(
                        fontSize: Dimensions.sp13,
                        fontWeight: FontWeight.w400,
                        color: ColorResources.color9a9a9a,
                        fontFamily: 'Roboto',
                      ))),
              Expanded(
                flex: 70,
                child: Text(
                  item.startedDate ?? "",
                  style: TextStyle(
                    fontSize: Dimensions.sp14,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.color9a9a9a,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                  flex: 30,
                  child: Text("${getTranslated("due_date", context)!}:",
                      style: TextStyle(
                        fontSize: Dimensions.sp13,
                        fontWeight: FontWeight.w400,
                        color: ColorResources.color9a9a9a,
                        fontFamily: 'Roboto',
                      ))),
              Expanded(
                flex: 70,
                child: Text(
                  item.dueDate ?? "",
                  style: TextStyle(
                    fontSize: Dimensions.sp14,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.color9a9a9a,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 30,
                  child: Text("${getTranslated("status", context)!}:",
                      style: TextStyle(
                        fontSize: Dimensions.sp13,
                        fontWeight: FontWeight.w400,
                        color: ColorResources.color9a9a9a,
                        fontFamily: 'Roboto',
                      ))),
              Expanded(
                flex: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: statusColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(statusText,
                        style: TextStyle(
                          fontSize: Dimensions.sp12,
                          fontWeight: FontWeight.w500,
                          color: statusColor,
                          fontFamily: 'Roboto',
                        )),
                    const SizedBox(width: 10),
                    if (sessionUserId == (item.userId ?? ""))
                      GestureDetector(
                        onTap: () {
                          showBottomMenuSheet(context, item, statusText);
                        },
                        child: Image.asset(
                          Images.imgEditRed,
                          width: 18,
                          height: 18,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                  flex: 30,
                  child: Text("${getTranslated("responsible", context)!}:",
                      style: TextStyle(
                        fontSize: Dimensions.sp13,
                        fontWeight: FontWeight.w400,
                        color: ColorResources.color9a9a9a,
                        fontFamily: 'Roboto',
                      ))),
              Expanded(
                flex: 70,
                child: Text(
                  item.responsibleName ?? "",
                  style: TextStyle(
                    fontSize: Dimensions.sp14,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.color9a9a9a,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
          if (themesText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Expanded(
                      flex: 30,
                      child: Text("${getTranslated("linked_risks", context)}:",
                          style: TextStyle(
                            fontSize: Dimensions.sp13,
                            fontWeight: FontWeight.w400,
                            color: ColorResources.color9a9a9a,
                            fontFamily: 'Roboto',
                          ))),
                  Expanded(
                    flex: 70,
                    child: Text(
                      themesText,
                      style: TextStyle(
                        fontSize: Dimensions.sp14,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.color9a9a9a,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (item.linkedActionOffloads != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Expanded(
                      flex: 30,
                      child: Text("${getTranslated("linked_offloads", context)}:",
                          style: TextStyle(
                            fontSize: Dimensions.sp13,
                            fontWeight: FontWeight.w400,
                            color: ColorResources.color9a9a9a,
                            fontFamily: 'Roboto',
                          ))),
                  Expanded(
                    flex: 70,
                    child: Text(
                      "${item.linkedActionOffloads}",
                      style: TextStyle(
                        fontSize: Dimensions.sp14,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.color9a9a9a,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

void showBottomMenuSheet(BuildContext context, ViewActionListData itemData, String status) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      String statusText = "notStarted";
      if (status == "started"||status=="Started") {
        statusText = "started";
      } else if (status == "completed") {
        statusText = "complete";
      }
      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            statusText = "notStarted";
                          });
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              statusText == "notStarted" ? Images.imgActionCircleCheckRed : Images.imgActionCircleUncheckRed,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              getTranslated("not_started", context)!,
                              style: TextStyle(
                                fontSize: Dimensions.sp14,
                                color: ColorResources.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          setState(() {
                            statusText = "started";
                          });
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              statusText == "started" ? Images.imgActionCircleCheckYellow : Images.imgActionCircleUncheckYellow,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              getTranslated("started", context)!,
                              style: TextStyle(
                                fontSize: Dimensions.sp14,
                                color: ColorResources.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          setState(() {
                            statusText = "complete";
                          });
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              statusText == "complete" ? Images.imgActionCircleCheckGreen : Images.imgActionCircleUncheckGreen,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              getTranslated("complete", context)!,
                              style: TextStyle(
                                fontSize: Dimensions.sp14,
                                color: ColorResources.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          String orgStatus = "";
                          if (statusText == "started"||statusText=="Started") {
                            orgStatus = "Started";
                          }
                          if (statusText == "complete"|| statusText =="completed") {
                            orgStatus = "Completed";
                          }
                          if (statusText == "notStarted"|| statusText=="Not Started") {
                            orgStatus = "Not Started";
                          }
                         Provider.of<ProfileController>(context,listen: false).updateActionItemStatus(itemData.id.toString(), orgStatus);
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          decoration: BoxDecoration(
                            color: ColorResources.mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            getTranslated("submit", context)!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: Dimensions.sp16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
