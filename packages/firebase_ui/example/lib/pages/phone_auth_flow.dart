import 'package:firebase_ui/firebase_ui.dart';
import 'package:flutter/material.dart';

class PhoneAuthFlow extends StatelessWidget {
  final AuthMethod authMethod;

  const PhoneAuthFlow({Key? key, required this.authMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final phoneInputKey = GlobalKey<PhoneInputState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify phone number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: AuthFlowBuilder<PhoneVerificationController>(
            method: authMethod,
            listener: (_, newState) {
              if (newState is SignedIn || newState is CredentialLinked) {
                Navigator.of(context).pop();
              }
            },
            builder: (_, state, ctrl, __) {
              if (state is AwatingPhoneNumber) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PhoneInput(
                      onSubmitted: ctrl.acceptPhoneNumber,
                      key: phoneInputKey,
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        final number = PhoneInput.getPhoneNumber(phoneInputKey);
                        ctrl.acceptPhoneNumber(number);
                      },
                      child: const Text('Verify'),
                    ),
                  ],
                );
              }

              if (state is SMSCodeRequested ||
                  state is CredentialReceived ||
                  state is PhoneVerified) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is SMSCodeSent) {
                final key = GlobalKey<SMSCodeInputState>();
                return Column(
                  children: [
                    Expanded(child: SMSCodeInput(key: key)),
                    OutlinedButton(
                      onPressed: () {
                        ctrl.verifySMSCode(key.currentState!.code);
                      },
                      child: const Text('Verify the code'),
                    ),
                  ],
                );
              }

              return Text('Unknown auth flow state $state');
            },
          ),
        ),
      ),
    );
  }
}
