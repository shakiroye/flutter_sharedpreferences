import 'package:flutter/material.dart';
import 'package:flutter_sharedpreferences_login/models.dart';
import 'package:flutter_sharedpreferences_login/preferences_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _preferencesService = PreferencesService();

  final _usernameController = TextEditingController();
  var _selectedLanguages = Set<ProgrammingLanguage>();
  var _selectedGender = Gender.FEMALE;
  var _isEmployed = false;
  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  void _populateFields() async {
    final settings = await _preferencesService.getSettings();
    setState(() {
      _usernameController.text = settings.username;
      _selectedGender = settings.gender;
      _selectedLanguages = settings.programmingLanguages;
      _isEmployed = settings.isEmployed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Settings'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
            ),
            RadioListTile(
              title: const Text('Female'),
              value: Gender.FEMALE,
              groupValue: _selectedGender,
              onChanged: (newValue) =>
                  setState(() => _selectedGender = newValue!),
            ),
            RadioListTile(
              title: const Text('Male'),
              value: Gender.MALE,
              groupValue: _selectedGender,
              onChanged: (newValue) =>
                  setState(() => _selectedGender = newValue!),
            ),
            RadioListTile(
              title: const Text('Other'),
              value: Gender.OTHER,
              groupValue: _selectedGender,
              onChanged: (newValue) =>
                  setState(() => _selectedGender = newValue!),
            ),
            CheckboxListTile(
              title: Text('Dart'),
              value: _selectedLanguages.contains(ProgrammingLanguage.DART),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.DART)
                      ? _selectedLanguages.remove(ProgrammingLanguage.DART)
                      : _selectedLanguages.add(ProgrammingLanguage.DART);
                });
              },
            ),
            CheckboxListTile(
              title: Text('JavaScript'),
              value:
                  _selectedLanguages.contains(ProgrammingLanguage.JAVASCRIPT),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.JAVASCRIPT)
                      ? _selectedLanguages
                          .remove(ProgrammingLanguage.JAVASCRIPT)
                      : _selectedLanguages.add(ProgrammingLanguage.JAVASCRIPT);
                });
              },
            ),
            CheckboxListTile(
              title: Text('Kotlin'),
              value: _selectedLanguages.contains(ProgrammingLanguage.KOTLIN),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.KOTLIN)
                      ? _selectedLanguages.remove(ProgrammingLanguage.KOTLIN)
                      : _selectedLanguages.add(ProgrammingLanguage.KOTLIN);
                });
              },
            ),
            CheckboxListTile(
              title: Text('Swift'),
              value: _selectedLanguages.contains(ProgrammingLanguage.SWIFT),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguage.SWIFT)
                      ? _selectedLanguages.remove(ProgrammingLanguage.SWIFT)
                      : _selectedLanguages.add(ProgrammingLanguage.SWIFT);
                });
              },
            ),
            SwitchListTile(
                title: Text('Is Employed'),
                value: _isEmployed,
                onChanged: (newValue) =>
                    setState(() => _isEmployed = newValue)),
            TextButton(
              onPressed: _saveSettings,
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSettings() {
    final newSettings = Settings(
      username: _usernameController.text,
      gender: _selectedGender,
      programmingLanguages: _selectedLanguages,
      isEmployed: _isEmployed,
    );

    print(newSettings);
    _preferencesService.saveSettings(newSettings);
  }
}
