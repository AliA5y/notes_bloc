import 'package:flutter/material.dart';
import 'package:notes_bloc/shared.dart';
import 'package:notes_bloc/views/widgets/custom_toggle_switch.dart';

class QuickToggleSettingTile extends StatelessWidget {
  const QuickToggleSettingTile({
    super.key,
    required this.values,
    required this.switchAction,
    required this.isSwitched,
  });
  final Map<String, String> values;
  final void Function() switchAction;
  final bool isSwitched;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            values['title']!,
            style: Styles.headlineSmall,
          ),
        ),
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(values['first']!),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: CustomToggleSwitch(
                    size: 28,
                    switchAction: switchAction,
                    isSwitched: isSwitched,
                  ),
                ),
              ),
              Text(values['second']!),
            ],
          ),
        )
      ],
    );
  }
}
