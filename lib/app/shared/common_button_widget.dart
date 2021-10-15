import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final bool isDisabled;
  final String label;
  final bool enabled;
  const CommonButtonWidget({
    Key? key,
    required this.onTap,
    this.isDisabled = false,
    required this.label,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 170,
        decoration: BoxDecoration(
          color: enabled
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(label),
      ),
      onTap: enabled ? onTap : null,
    );
  }
}
