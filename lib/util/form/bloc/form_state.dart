import 'package:equatable/equatable.dart';

class FormBlocState extends Equatable {
  final Map<String, dynamic> formValues;
  final bool isValid;

  const FormBlocState({
    this.formValues = const {},
    this.isValid = false,
  });

  FormBlocState copyWith({
    Map<String, dynamic>? formValues,
    bool? isValid,
  }) {
    return FormBlocState(
      formValues: formValues ?? this.formValues,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [formValues, isValid];
}
