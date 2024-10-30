import 'package:flutter/material.dart';
import 'package:ipass_poc/util/form_render.dart';

class MutuellePage extends StatelessWidget {
  const MutuellePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mutuelle de sante'),
      ),
      body: Container(
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
            FormRenderer(
              formConfig: const [
                // {
                //   "key": "APPLICANT_FIRST_NAME",
                //   "type": "custom-input",
                //   "templateOptions": {
                //     "required": true,
                //     "textlabel": "First Name",
                //     "placeholder": "Enter first name",
                //   },
                // },
                // {
                //   "key": "SPACE",
                //   "type": "custom-space",
                //   "templateOptions": {
                //     "height": 30,
                //   },
                // },
                // {
                //   "key": "GENDER",
                //   "type": "custom-radio",
                //   "templateOptions": {
                //     "textlabel": "Gender",
                //     "options": [
                //       {"label": "Male", "value": "male"},
                //       {"label": "Female", "value": "female"},
                //       {"label": "They", "value": "they"},
                //     ],
                //   },
                // },
                // {
                //   "key": "COUNTRY",
                //   "type": "custom-dropdown",
                //   "templateOptions": {
                //     "textlabel": "Country",
                //     "options": [
                //       {"label": "United States", "value": "us"},
                //       {"label": "Canada", "value": "ca"},
                //       {"label": "United Kingdom", "value": "uk"},
                //     ],
                //   },
                // },
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
                  Text('Paying with :',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                  const SizedBox(width: 4),
                  const Text('0780 000 000',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  const Text('Edit',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            TextButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.all(13),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    'Pay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )

            // FormRenderer().getSubmitButton(),
          ],
        ),
      ),
    );
  }
}
