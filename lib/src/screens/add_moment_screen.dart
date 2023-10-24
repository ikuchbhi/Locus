import 'package:flutter/material.dart';

import '../widgets/util/custom_text_form_field.dart';

class AddMomentScreen extends StatefulWidget {
  const AddMomentScreen({super.key});

  @override
  State<AddMomentScreen> createState() => _AddMomentScreenState();
}

class _AddMomentScreenState extends State<AddMomentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Moment"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: [
          CustomTextFormField(
            "Title",
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          CustomTextFormField(
            "Moment Type",
            DropdownButton(
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Text("Text Only"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("Image Only"),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text("Image with Caption"),
                ),
              ],
              onChanged: (v) {},
            ),
          ),
          CustomTextFormField(
            "Choose Location",
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.pin_drop_rounded),
                onPressed: () {},
                label: const Text("Select Location"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith(
                    (_) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (_) => Theme.of(context).colorScheme.secondary,
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (_) => Colors.grey.shade50,
                  ),
                  textStyle: MaterialStateProperty.resolveWith(
                    (_) => const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Aleo',
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomTextFormField(
            "Choose Image",
            ElevatedButton.icon(
              icon: const Icon(Icons.image_outlined),
              onPressed: () {},
              label: const Text("Select Image"),
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith(
                  (_) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (_) => Theme.of(context).colorScheme.secondary,
                ),
                foregroundColor: MaterialStateProperty.resolveWith(
                  (_) => Colors.grey.shade50,
                ),
                textStyle: MaterialStateProperty.resolveWith(
                  (_) => const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Aleo',
                  ),
                ),
              ),
            ),
          ),
          CustomTextFormField(
            "Add Caption",
            TextFormField(
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            onPressed: () {},
            label: const Text("Save"),
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith(
                (_) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (_) => Theme.of(context).colorScheme.secondary,
              ),
              foregroundColor: MaterialStateProperty.resolveWith(
                (_) => Colors.grey.shade50,
              ),
              textStyle: MaterialStateProperty.resolveWith(
                (_) => const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aleo',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
