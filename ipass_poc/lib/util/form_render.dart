import 'package:flutter/material.dart';

import 'nid_fetch.dart';

class FormRenderer extends StatefulWidget {
  final List<Map<String, dynamic>> formConfig;

  FormRenderer({required this.formConfig});

  @override
  _FormRendererState createState() => _FormRendererState();
}

class _FormRendererState extends State<FormRenderer> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> _formData;

  @override
  void initState() {
    super.initState();
    _formData = {};
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          for (final fieldConfig in widget.formConfig)
            _buildFormField(fieldConfig),
          
        ],
      ),
    );
  }

  Widget _buildFormField(Map<String, dynamic> fieldConfig) {
    final type = fieldConfig['type'];
    final options = fieldConfig['templateOptions'];

    switch (type) {
      case 'custom-input':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              options['textlabel'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (value) =>
                  options['required'] && (value == null || value.isEmpty)
                      ? options['textlabel']
                      : null,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                hintText: options['placeholder'],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              onSaved: (value) => _formData[fieldConfig['key']] = value,
            ),
          ],
        );
      case 'custom-radio':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              options['textlabel'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (final option in options['options']) ...[
                      Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Radio<dynamic>(
                          value: option['value'],
                          groupValue: _formData[fieldConfig['key']],
                          onChanged: (value) => setState(
                              () => _formData[fieldConfig['key']] = value),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      Text(option['label']),
                      const SizedBox(width: 16),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      case 'custom-dropdown':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              options['textlabel'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              items: [
                for (final option in options['options'])
                  DropdownMenuItem(
                    value: option['value'],
                    child: Text(option['label']),
                  ),
              ],
              onChanged: (value) =>
                  setState(() => _formData[fieldConfig['key']] = value),
              value: _formData[fieldConfig['key']],
            ),
          ],
        );
      case 'custom-checkbox':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(options['textlabel']),
            for (final option in options['options'])
              CheckboxListTile(
                title: Text(option['label']),
                value: _formData[fieldConfig['key']]?.contains(option['value']),
                onChanged: (value) {
                  final currentValues = _formData[fieldConfig['key']] ?? [];
                  if (value == true) {
                    currentValues.add(option['value']);
                  } else {
                    currentValues.remove(option['value']);
                  }
                  setState(() => _formData[fieldConfig['key']] = currentValues);
                },
              ),
          ],
        );
      case "custom-space":
        final height = (options['height'] ?? 5).toDouble();
        return SizedBox(height: height);
      case "nid-fetch":
        return NIDFetchField(
          label: options['textlabel'],
          placeholder: options['placeholder'],
          onNIDDetailsUpdated: (nidDetails) {
            setState(() {
              _formData[fieldConfig['key']] = nidDetails;
            });
          },
        );
      default:
        return SizedBox.shrink();
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Process the _formData map as needed
      print(_formData);
    }
  }

  Widget getSubmitButton() {
    return TextButton(
      onPressed: _submitForm,
      child: Container(
        padding: const EdgeInsets.all(13),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            'Submit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
