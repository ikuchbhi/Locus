import 'dart:async';

import 'package:flutter/material.dart';

class TermsAndConditionsField extends StatefulWidget {
  final StreamController<bool> tnc;
  const TermsAndConditionsField(this.tnc, {super.key});

  @override
  State<TermsAndConditionsField> createState() =>
      _TermsAndConditionsFieldState();
}

class _TermsAndConditionsFieldState extends State<TermsAndConditionsField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          StreamBuilder<bool>(
            stream: widget.tnc.stream,
            builder: (c, snapshot) {
              return Checkbox(
                value: snapshot.data ?? false,
                activeColor: Theme.of(c).primaryColor,
                onChanged: (v) => widget.tnc.sink.add(v!),
                side: BorderSide(color: Colors.grey.shade700, width: 1.5),
              );
            }
          ),
          const Text(
            "I agree to the Terms and Conditions",
            style: TextStyle(fontWeight: FontWeight.w100),
          ),
        ],
      ),
    );
  }
}
