import 'package:flutter/material.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Languages',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            _buildLanguageTile(
              title: 'English',
              value: _selectedLanguage == 'English',
              onChanged: (bool? value) {
                if (value != null) _updateLanguage('English');
              },
            ),
            _buildLanguageTile(
              title: 'Kinyarwanda',
              value: _selectedLanguage == 'Kinyarwanda',
              onChanged: (bool? value) {
                if (value != null) _updateLanguage('Kinyarwanda');
              },
            ),
            _buildLanguageTile(
              title: 'French',
              value: _selectedLanguage == 'French',
              onChanged: (bool? value) {
                if (value != null) _updateLanguage('French');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  Widget _buildLanguageTile({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Color(0xFF475467),
        ),
      ),
      onTap: () => onChanged(!value),
      trailing: Checkbox(
        value: value,
        onChanged: onChanged,
        side: const BorderSide(
          color: Colors.transparent,
        ),
        activeColor: Colors.transparent,
        checkColor: Colors.blue,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      horizontalTitleGap: 0,
      dense: true,
      visualDensity: VisualDensity.compact,
      isThreeLine: false,
      enabled: true,
      selected: false,
      selectedTileColor: Colors.grey.withOpacity(0.2),
      shape:  Border(
        bottom: BorderSide(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
    );
  }
}
