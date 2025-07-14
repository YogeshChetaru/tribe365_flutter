import 'package:flutter/material.dart';
import '../domain/models/view_dot_details_response.dart';

class BeliefHorizontalList extends StatelessWidget {
  final List<Belief> beliefs;

  const BeliefHorizontalList({
    required this.beliefs,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: beliefs.length,
        itemBuilder: (context, index) {
          final belief = beliefs[index];
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        belief.name!,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: ListView.builder(
                    itemCount: belief.beliefValue?.length ?? 0,
                    itemBuilder: (context, subIndex) {
                      final value = belief.beliefValue![subIndex];
                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 6,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: value.isSelected == "t" ? Colors.red[100] : Colors.grey[200],
                          ),
                          child: Text(
                            value.name ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
