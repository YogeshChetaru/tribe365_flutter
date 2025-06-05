import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tribe365_new/utill/color_resources.dart';
import '../../../../common/basewidget/custom_button_widget.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';

class AppExitCard extends StatelessWidget {
  const AppExitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 40, top: 15),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeDefault))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: Theme.of(context).hintColor.withAlpha(128), borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: SizedBox(width: 60, child: Image.asset(Images.exitIcon)),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),
          Text(
            getTranslated('close_the_app', context)!,
            style: TextStyle(fontFamily: 'roboto', fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
            child: Text('${getTranslated('do_you_want_to_close_and_exit_app', context)}'),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOverLarge),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                    child: SizedBox(
                        width: 120,
                        child: CustomButton(
                          buttonText: '${getTranslated('cancel', context)}',
                          backgroundColor: ColorResources.colorAAADC4,
                          textColor: ColorResources.black,
                          onTap: () => Navigator.pop(context),
                        ))),
                const SizedBox(
                  width: Dimensions.paddingSizeDefault,
                ),
                Expanded(child: SizedBox(width: 120, child: CustomButton(textColor: ColorResources.white,buttonText: '${getTranslated('exit', context)}', onTap: () => {Navigator.of(context).pop(true), SystemNavigator.pop()})))
              ]))
        ],
      ),
    );
  }
}
