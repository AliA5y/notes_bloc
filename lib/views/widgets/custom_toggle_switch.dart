import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch(
      {super.key, required this.size, required this.switchAction});
  final double size;
  final void Function() switchAction;

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch>
    with SingleTickerProviderStateMixin {
  final double nobStartPosition = 3;
  late double nobEndPosition;
  bool _isSwitched = false;
  late AnimationController _animationController;

  @override
  void initState() {
    nobEndPosition = widget.size - nobStartPosition;
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _toggleSwitch() {
    if (_isSwitched) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      _isSwitched = !_isSwitched;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isSwitched = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            _toggleSwitch();
            widget.switchAction();
          },
          child: Container(
            width: widget.size * 2,
            height: widget.size,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context)
                    .colorScheme
                    .inverseSurface
                    .withAlpha(100)),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: _isSwitched ? nobEndPosition : nobStartPosition,
                  top: nobStartPosition,
                  child: Container(
                    width: widget.size,
                    height: widget.size - (nobStartPosition * 2),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      color:
                          Theme.of(context).colorScheme.surface.withAlpha(250),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
