import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locus/src/controllers/theme/theme_cubit.dart';

import '../controllers/settings/settings.dart';
import '../models/theme.dart';
import '../widgets/settings/settings_list_divider.dart';
import '../widgets/settings/update_dialog.dart';

class SettingsScreen extends StatefulWidget {
  final String userEmail;
  const SettingsScreen(this.userEmail, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late GlobalKey<FormState> _key;
  late ThemeType _val;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final settingsCubit = SettingsCubit(context.read());
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        bloc: settingsCubit,
        builder: (cc, s) {
          if (s is LoadingSettingsState) {
            settingsCubit.getSettings(widget.userEmail);
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (s is LoadedSettingsState) {
            return Form(
              key: _key,
              onWillPop: () async {
                final ans = await showDialog<bool>(
                  context: cc,
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
                      context: cc,
                      titleText: "Change Username",
                      initialValue: s.locusUser.username,
                      onChange: (v) => settingsCubit.setUsername(
                        widget.userEmail,
                        v,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text("Change Name"),
                    onTap: () => showUpdateDialog(
                      context: cc,
                      titleText: "Change Name",
                      initialValue: s.locusUser.name,
                      onChange: (v) => settingsCubit.setName(widget.userEmail, v),
                    ),
                  ),
                  ListTile(
                    title: const Text("Change Biodata"),
                    onTap: () => showUpdateDialog(
                      context: cc,
                      titleText: "Change Biodata",
                      initialValue: s.locusUser.bioData,
                      onChange: (v) => settingsCubit.setBiodata(
                        widget.userEmail,
                        v,
                      ),
                    ),
                  ),
                  const SettingsListDivider(),
                  const ListTile(
                    leading: Icon(Icons.settings_applications_sharp),
                    title: Text("App Settings"),
                  ),
                  const SettingsListDivider(),
                  BlocBuilder<ThemeCubit, LocusTheme>(
                      bloc: themeCubit,
                      builder: (ccc, s) {
                        _val = s.type;
                        return ListTile(
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
                            onChanged: (nTT) {
                              if (nTT != _val) {
                                themeCubit.toggleTheme();
                              }
                            },
                          ),
                        );
                      }),
                ],
              ),
            );
          } else if (s is ErrorSettingsState) {
            return Center(
              child: Text(
                s.error,
                style: Theme.of(cc).textTheme.headlineSmall,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
