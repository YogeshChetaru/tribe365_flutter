import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../controllers/profile_controller.dart';

class TeamRoleBuildStatement extends StatefulWidget {
  final int index;
  const TeamRoleBuildStatement({super.key,required this.index});

  @override
  State<TeamRoleBuildStatement> createState() => _TeamRoleBuildStatementState();
}

class _TeamRoleBuildStatementState extends State<TeamRoleBuildStatement> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, profileProvider, _) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(top: 15,bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${profileProvider.statements[widget.index]['label']}  ',
                      style: const TextStyle(
                        fontSize: Dimensions.sp16,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.color333333,
                        fontFamily: 'Roboto'
                      ),
                    ),
                    Expanded(
                      flex: 1,child: Text(
                        '${profileProvider.statements[widget.index]['text']}',
                        style: const TextStyle(
                            fontSize: Dimensions.sp14,
                            fontWeight: FontWeight.w600,
                            color: ColorResources.color9a9a9a,
                            fontFamily: 'Roboto'
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(width: MediaQuery.sizeOf(context).width,height: 0.5,
              color: ColorResources.color9a9a9a,),
              const SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(width: 0.5,color: ColorResources.color808080)
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (profileProvider.counters[widget.index]! > 0) {
                            profileProvider.updateCountersSubtraction(widget.index);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 15,),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(width: 0.5,color: ColorResources.color808080)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${profileProvider.counters[widget.index]}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(width: 0.5,color: ColorResources.color808080)
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          profileProvider.updateCountersAddition(widget.index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
