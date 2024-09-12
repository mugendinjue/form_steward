import 'package:flutter/material.dart';
import 'package:form_steward/src/state/form_steward_state_notifier.dart';
import 'package:form_steward/src/state/validation_trigger_notifier.dart';
import '../models/form_step_model.dart';
import 'form_field_widget.dart';

/// A widget that builds a dynamic form based on a list of form steps.
///
/// The [FormBuilder] class takes a list of [FormStepModel] instances and
/// dynamically generates a form. Each form step is represented by a
/// [FormStepModel], which includes a title and a list of fields. The
/// widget uses [FormFieldWidget] to render each field within the form steps.
class FormBuilder extends StatelessWidget {
  /// The list of form steps to be built into the form.
  ///
  /// The [steps] parameter is a list of [FormStepModel] instances that define
  /// the structure and content of the form. Each step includes a title and
  /// a list of fields to be displayed in that step.
  final List<FormStepModel> steps;

  // Instance of FormStewardStateNotifier
  final ValidationTriggerNotifier validationTriggerNotifier;

  final FormStewardStateNotifier formStewardStateNotifier;

  /// Creates a new instance of the [FormBuilder] class.
  ///
  /// The [steps] parameter is required and should contain the form steps
  /// that define the form's structure.
  ///
  /// - Parameter steps: The list of form steps to be rendered.
  const FormBuilder({
    super.key,
    required this.steps,
    required this.validationTriggerNotifier,
    required this.formStewardStateNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.map((step) {
        // Initialize step validity
        final Map<String, bool> fieldsValidity = {
          for (var field in step.fields) field.name: true
        };
        formStewardStateNotifier.initializeStepValidity(
          stepValidity: {
            step.name: fieldsValidity,
          },
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...step.fields.map((field) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: FormFieldWidget(
                  field: field,
                  stepName: step.name,
                  validationTriggerNotifier: validationTriggerNotifier,
                  formStewardStateNotifier: formStewardStateNotifier,
                ),
              );
            }),
          ],
        );
      }).toList(),
    );
  }
}
