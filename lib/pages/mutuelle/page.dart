// page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipass_poc/util/form/bloc/form_bloc.dart';
import 'package:ipass_poc/util/form/bloc/form_state.dart';
import 'package:ipass_poc/util/form/form_render.dart';

class MutuellePage extends StatelessWidget {
  const MutuellePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mutuelle de sante'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please provide the following details',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 20),
                const FormRenderer(
                  formConfig: [
                    {
                      "key": "NID_NUMBER",
                      "type": "nid-fetch",
                      "templateOptions": {
                        "textlabel": "Head of the household ID number",
                        "placeholder": "Enter 16-digit NID number",
                      },
                    },
                    {
                      "key": "SPACE",
                      "type": "custom-space",
                      "templateOptions": {
                        "height": 10,
                      },
                    },
                    {
                      "key": "AMOUNT",
                      "type": "custom-input",
                      "hideExpression": "model.NID_NUMBER == null",
                      "templateOptions": {
                        "required": true,
                        "textlabel": "Amount to pay",
                        "placeholder": "Enter the amount to pay",
                      },
                    },
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Paying with :',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '0780 000 000',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<FormBloc, FormBlocState>(
                  builder: (context, state) {
                    final amount = state.formValues['AMOUNT'] as String?;
                    final bool isAmountValid =
                        amount != null && amount.isNotEmpty;
                    return TextButton(
                      onPressed: isAmountValid
                          ? () {
                              print('Form Values: ${state.formValues}');
                            }
                          : null,
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isAmountValid ? Colors.purple : Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            isAmountValid ? 'Pay $amount RWF' : 'Enter amount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
