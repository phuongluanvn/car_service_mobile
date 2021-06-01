import 'dart:js';

import 'package:car_service/blocs/confirm/confirmation_bloc.dart';
import 'package:car_service/blocs/confirm/confirmation_events.dart';
import 'package:car_service/blocs/confirm/confirmation_state.dart';
import 'package:car_service/form_submission_status.dart';
import 'package:car_service/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationUi extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ConfirmBloc(
          repo: context.read<AuthRepository>(),
        ),
        child: _confirmationForm(),
      ),
    );
  }

  Widget _confirmationForm() {
    return BlocListener<ConfirmBloc, ConfirmState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _codeField(),
              _confirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _codeField() {
    return BlocBuilder<ConfirmBloc, ConfirmState>(builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Confirm Code',
        ),
        validator: (value) => state.isValidCode ? null : 'Invalid Confirm Code',
        onChanged: (value) => context
            .read<ConfirmBloc>()
            .add(ConfirmationCodeChanged(code: value)),
      );
    });
  }

  Widget _confirmButton() {
    return BlocBuilder<ConfirmBloc, ConfirmState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.read<ConfirmBloc>().add(ConfirmationSubmitted());
                }
              },
              child: Text('Confirm'),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
