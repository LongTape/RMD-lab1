import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? errorMessage;

  AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      // Імітація перевірки:
      await Future.delayed(Duration(seconds: 2));
      if (email == "test@example.com" && password == "password") {
        emit(state.copyWith(isLoggedIn: true, isLoading: false));
      } else {
        throw Exception("Invalid email or password");
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> register(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await Future.delayed(Duration(seconds: 2));
      if (email.isNotEmpty && password.length >= 6) {
        emit(state.copyWith(isLoggedIn: true, isLoading: false));
      } else {
        throw Exception("Invalid input data");
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
