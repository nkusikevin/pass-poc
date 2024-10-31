import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipass_poc/util/form/bloc/form_bloc.dart';
import 'bloc/form_event.dart';
import 'bloc/form_state.dart';
import 'nid_fetch.dart';

class FormRenderer extends StatefulWidget {
  final List<Map<String, dynamic>> formConfig;

  const FormRenderer({required this.formConfig});

  @override
  _FormRendererState createState() => _FormRendererState();
}

class _FormRendererState extends State<FormRenderer> {
  final _formKey = GlobalKey<FormState>();

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
    final key = fieldConfig['key'];

    switch (type) {
      case 'custom-input':
        return BlocBuilder<FormBloc, FormBlocState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  options['textlabel'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: state.formValues[key]?.toString(),
                  validator: (value) =>
                      options['required'] && (value == null || value.isEmpty)
                          ? '${options['textlabel']} is required'
                          : null,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: options['placeholder'],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<FormBloc>().add(UpdateFormValue(key, value));
                  },
                ),
              ],
            );
          },
        );
      case 'custom-radio':
        return BlocBuilder<FormBloc, FormBlocState>(
          builder: (context, state) {
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
                              groupValue: state.formValues[key],
                              onChanged: (value) {
                                context
                                    .read<FormBloc>()
                                    .add(UpdateFormValue(key, value));
                              },
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
          },
        );
      case 'custom-dropdown':
        return BlocBuilder<FormBloc, FormBlocState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  options['textlabel'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: state.formValues[key]?.toString(),
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
                  onChanged: (value) {
                    context.read<FormBloc>().add(UpdateFormValue(key, value));
                  },
                  items: [
                    for (final option in options['options'])
                      DropdownMenuItem(
                        value: option['value'],
                        child: Text(option['label']),
                      ),
                  ],
                ),
              ],
            );
          },
        );
      case 'nid-fetch':
        return NIDFetchField(
          label: options['textlabel'],
          placeholder: options['placeholder'],
          onNIDDetailsUpdated: (nidDetails) {
            context.read<FormBloc>().add(UpdateFormValue(key, nidDetails));
          },
        );

      case "custom-space":
        final height = (options['height'] ?? 5).toDouble();
        return SizedBox(height: height);

      default:
        return const SizedBox.shrink();
    }
  }
}
