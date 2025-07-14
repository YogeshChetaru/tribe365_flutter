import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/profile_controller.dart';

class TeamRoleBuildStatementUpdate extends StatelessWidget {
  final int index;

  const TeamRoleBuildStatementUpdate({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(builder: (context, profileProvider, _) {
      final option = profileProvider.currentOptionsUpdate[index];


      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                      '${option.alphabate}. ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        option.optionName ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9A9A9A),
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Divider(color: Color(0xFF9A9A9A), thickness: 0.5),
              const SizedBox(height: 10),

              // Counter UI
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    _buildCounterButton(
                      icon: Icons.remove,
                      onTap: () => profileProvider.decrementOptionUpdate(index),
                    ),
                    const SizedBox(width: 15),
                    _buildCounterDisplay(option.answer ?? '0'),
                    const SizedBox(width: 15),
                    _buildCounterButton(
                      icon: Icons.add,
                      onTap: () => profileProvider.incrementOptionUpdate(index),
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

  Widget _buildCounterButton({required IconData icon, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFF808080), width: 0.5),
      ),
      child: IconButton(icon: Icon(icon), onPressed: onTap),
    );
  }

  Widget _buildCounterDisplay(String value) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFF808080), width: 0.5),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
