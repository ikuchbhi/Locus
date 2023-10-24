import 'package:flutter/material.dart';

class DisplayNumberButton extends StatelessWidget {
  final int number;
  final String displayString;
  final VoidCallback? onTap;
  const DisplayNumberButton(
    this.number,
    this.displayString, {
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            number.toString(),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade100,
                  fontWeight: FontWeight.w800,
                ),
          ),
          Text(
            displayString,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey.shade100,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
