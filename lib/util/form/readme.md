# Form Renderer Configuration Guide

## Overview
The Form Renderer is a flexible Flutter widget that generates form fields based on a JSON configuration. It supports various input types and customization options.


## Features

🚀 Dynamic form generation from JSON
📱 Fully responsive design
✨ Rich set of customizable form fields
🔒 Built-in validation support
🎨 Customizable styling
♿ Accessibility support
🌐 Internationalization ready

## Supported Field Types

### 1. NID Fetch (`nid-fetch`)
A specialized input field for National ID numbers.


{
"key": "NID_NUMBER",
"type": "nid-fetch",
"templateOptions": {
"textlabel": "Head of the household ID number",
"placeholder": "Enter 16-digit NID number"
}
}


### 2. Custom Space (`custom-space`)
Adds vertical spacing between form elements.

json
{
"key": "SPACE",
"type": "custom-space",
"templateOptions": {
"height": 10
}
}


### 3. Custom Input (`custom-input`)
A standard text input field with customizable properties.

json
{
"key": "AMOUNT",
"type": "custom-input",
"templateOptions": {
"required": true,
"textlabel": "Amount to pay",
"placeholder": "Enter the amount to pay"
}
}



### 4. Custom Radio (`custom-radio`)
A group of radio buttons for single selection.


json
{
"key": "GENDER",
"type": "custom-radio",
"templateOptions": {
"textlabel": "Gender",
"options": [
{"label": "Male", "value": "male"},
{"label": "Female", "value": "female"},
{"label": "They", "value": "they"}
]
}
}



### 5. Custom Dropdown (`custom-dropdown`)
A dropdown menu for selecting from predefined options.


json
{
"key": "COUNTRY",
"type": "custom-dropdown",
"templateOptions": {
"textlabel": "Country",
"options": [
{"label": "United States", "value": "us"},
{"label": "Canada", "value": "ca"},
{"label": "United Kingdom", "value": "uk"}
]
}
}



## Field Configuration Structure

Each field configuration follows this basic structure:

json
{
"key": "FIELD_KEY", // Unique identifier for the field
"type": "field-type", // Type of form field to render
"templateOptions": { // Field-specific options
"textlabel": "Label", // Field label
"placeholder": "Hint", // Placeholder text
"required": boolean, // Whether the field is required
"options": [] // Array of options for radio/dropdown
}
}



## Usage

To use the Form Renderer, pass your configuration array to the `FormRenderer` widget:

dart
const FormRenderer(
formConfig: [
// Your field configurations here
],
)



The form values can be accessed through the `FormBloc` state using the field keys defined in the configuration.