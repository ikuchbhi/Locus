import 'package:flutter/material.dart';

import '../models/theme.dart';
import '../widgets/settings/settings_list_divider.dart';
import '../widgets/settings/update_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late GlobalKey<FormState> _key;
  var _val = ThemeType.light;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Form(
        key: _key,
        onWillPop: () async {
          final ans = await showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              title: Text(
                "Alert!",
                style: TextStyle(color: Colors.grey.shade50),
              ),
              content: Text(
                "You may have unsaved changes. Do you want to leave?",
                style: TextStyle(color: Colors.grey.shade50),
              ),
              actions: [
                TextButton(
                  child: const Text("Yes"),
                  onPressed: () {
                    Navigator.pop(c, true);
                  },
                ),
                TextButton(
                  child: const Text("No"),
                  onPressed: () => Navigator.pop(c, false),
                ),
              ],
            ),
          );
          return ans ?? false;
        },
        child: ListView(
          children: [
            const SettingsListDivider(),
            const ListTile(
              leading: Icon(Icons.person_rounded),
              title: Text("User Settings"),
            ),
            const SettingsListDivider(),
            ListTile(
              title: const Text("Change Username"),
              onTap: () => showUpdateDialog(
                context: context,
                initialValue: "User",
                titleText: "Change Username",
                onSave: () {},
              ),
            ),
            ListTile(
              title: const Text("Change Name"),
              onTap: () => showUpdateDialog(
                context: context,
                initialValue: "Name",
                titleText: "Change Name",
                onSave: () {},
              ),
            ),
            ListTile(
              title: const Text("Change Biodata"),
              onTap: () => showUpdateDialog(
                context: context,
                initialValue: "I am a user of Locus",
                titleText: "Change Biodata",
                onSave: () {},
              ),
            ),
            const SettingsListDivider(),
            const ListTile(
              leading: Icon(Icons.settings_applications_sharp),
              title: Text("App Settings"),
            ),
            const SettingsListDivider(),
            ListTile(
              leading: const Text(
                "App Theme",
                style: TextStyle(fontSize: 16),
              ),
              title: DropdownButton(
                value: _val,
                isExpanded: true,
                items: ThemeType.values
                    .map(
                      (tt) => DropdownMenuItem(
                        value: tt,
                        child: Text(
                          "${tt.name[0].toUpperCase()}${tt.name.substring(1)}",
                          style: TextStyle(
                            color: Colors.grey.shade50,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (nTT) => setState(() => _val = nTT!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save_outlined),
                onPressed: () {
                  
                },
                label: const Text("Save"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (_) => Theme.of(context).colorScheme.secondary,
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (_) => Colors.grey.shade50,
                  ),
                  shape: MaterialStateProperty.resolveWith(
                    (_) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
