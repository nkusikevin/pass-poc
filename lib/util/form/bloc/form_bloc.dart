import 'package:bloc/bloc.dart';
import 'form_event.dart';
import 'form_state.dart'; 


class FormBloc extends Bloc<FormBlocEvent, FormBlocState> {
  FormBloc() : super(const FormBlocState()) {
    on<UpdateFormValue>(_onUpdateFormValue);
    on<ValidateForm>(_onValidateForm);
    on<ResetForm>(_onResetForm);
  }

  void _onUpdateFormValue(UpdateFormValue event, Emitter<FormBlocState> emit) {
    final updatedValues = Map<String, dynamic>.from(state.formValues);
    updatedValues[event.key] = event.value;
    emit(state.copyWith(formValues: updatedValues));
  }

  void _onValidateForm(ValidateForm event, Emitter<FormBlocState> emit) {
    //TODO: Add validation logic
    final isValid = state.formValues.isNotEmpty;
    emit(state.copyWith(isValid: isValid));
  }

  void _onResetForm(ResetForm event, Emitter<FormBlocState> emit) {
    emit(const FormBlocState());
  }
}
