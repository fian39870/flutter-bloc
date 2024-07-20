import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;

        // Check if the email is valid
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
            .hasMatch(email)) {
          return emit(AuthFailure('Email tidak valid'));
        }

        // Check if the password meets the criteria
        if (!RegExp(
                r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$")
            .hasMatch(password)) {
          return emit(AuthFailure(
              'Password minimal 6 huruf, terdiri dari huruf besar, huruf kecil, angka dan simbol'));
        }

        // Simulate a login process
        await Future.delayed(const Duration(seconds: 1), () {
          return emit(AuthSuccess(uid: '$email-$password'));
        });
      },
    );
  }
}
