import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch(
      {super.key,
      required this.size,
      required this.switchAction,
      required this.isSwitched});
  final double size;
  final void Function() switchAction;
  final bool isSwitched;

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch>
    with SingleTickerProviderStateMixin {
  late double nobStartPosition = 3;
  late double nobEndPosition;
  bool _isSwitched = false;
  late AnimationController _animationController;

  @override
  void initState() {
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
    nobStartPosition = widget.size / 12;
    nobEndPosition = widget.size * (2.2 - 1) - nobStartPosition;
    _isSwitched = widget.isSwitched;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            _toggleSwitch();
            widget.switchAction();
          },
          child: Container(
            width: widget.size * 2.2,
            height: widget.size + nobStartPosition * 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.size / 4),
                color: Theme.of(context).colorScheme.inverseSurface),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  left: _isSwitched ? nobEndPosition : nobStartPosition,
                  top: nobStartPosition,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(widget.size / 5)),
                      color: Theme.of(context).colorScheme.surface,
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
