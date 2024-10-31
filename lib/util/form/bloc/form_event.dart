abstract class FormBlocEvent {}

class UpdateFormValue extends FormBlocEvent {
  final String key;
  final dynamic value;

  UpdateFormValue(this.key, this.value);
}

class ValidateForm extends FormBlocEvent {}

class ResetForm extends FormBlocEvent {}
