import 'package:flutter/material.dart';
import 'package:tribe365_new/localization/language_constrants.dart';
import 'package:tribe365_new/utill/images.dart';
import '../../../../utill/color_resources.dart';
import '../domain/models/view_dot_details_response.dart';

class RatingDialog extends StatefulWidget {
  final BeliefValue value;
  final String dotId;
  final String beliefId;
  final String valueId;
  final Function(double) onSubmit;

  const RatingDialog({
    required this.value,
    required this.dotId,
    required this.beliefId,
    required this.valueId,
    required this.onSubmit,
    super.key,
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double rating = 0;

  @override
  void initState() {
    super.initState();
    rating = double.tryParse(widget.value.ratings ?? '') ?? 0;
  }

  String getRatingText(double r) {
    final name = widget.value.name ?? "";
    switch (r.toInt()) {
      case 0:
        return "$r - ${getTranslated("i_do_not_understand_what_it_means_to_be", context)} $name";
      case 1:
        return "$r - ${getTranslated("i_understand_what_it_means_to_be", context)} $name, ${getTranslated("i_am_never_rarely", context)} $name";
      case 2:
        return "$r - ${getTranslated("i_understand_what_it_means_to_be", context)} $name, ${getTranslated("i_am", context)} $name ${getTranslated("when_i_have_to_be", context)}";
      case 3:
        return "$r - ${getTranslated("i_understand_what_it_means_to_be", context)} $name, ${getTranslated("i_am", context)} $name ${getTranslated("every_day_at_work", context)}";
      case 4:
        return "$r - ${getTranslated("i_understand_what_it_means_to_be", context)} $name, ${getTranslated("i_am", context)} $name ${getTranslated("every_day_at_work_colleagues_and_clients_would_describe_me_as", context)} $name";
      case 5:
        return "$r - ${getTranslated("i_understand_what_it_means_to_be", context)} $name, ${getTranslated("i_am", context)} $name ${getTranslated("every_day_at_work_colleagues_and_clients_would_describe_me_as", context)} $name, ${getTranslated("i_help_others_become", context)} $name";
      default:
        return "$r";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(onTap: (){
                Navigator.pop(context);
              },
                  child: Image.asset(Images.cancelled,width: 24,height: 24,)),
            ),
            Text(
              widget.value.name ?? "",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Roboto"
              ),
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: ColorResources.mainColor, // Selected track (line) color
                inactiveTrackColor: Colors.grey[300], // Unselected track color
                trackHeight: 4.0,
                thumbColor: ColorResources.mainColor, // Indicator color
                overlayColor: ColorResources.mainColor.withAlpha(32), // Thumb ripple effect
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 18.0),
                valueIndicatorColor: ColorResources.mainColor, // Popup value indicator color
                valueIndicatorTextStyle: const TextStyle(color: Colors.white),
              ),
              child: Slider(
                value: rating,
                min: 0,
                max: 5,
                divisions: 5,
                label: rating.toStringAsFixed(0),
                onChanged: (val) {
                  setState(() {
                    rating = val;
                  });
                },
              ),
            ),
            Text(
              getRatingText(rating),
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onSubmit(rating);

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.mainColor,
                  minimumSize: const Size(120, 35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  getTranslated("done", context)!,
                  style: TextStyle(color: Colors.white,fontSize: 18,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
