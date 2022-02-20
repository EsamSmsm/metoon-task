import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool showPassword = true;
  IconData passwordIcon = Icons.visibility;

  void changePasswordVisibility() {
    showPassword = !showPassword;
    passwordIcon = showPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> logIn({String email, password}) async {
    emit(LoginLoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user.email != null) {
        emit(LoginSuccessState());
      }
      print(userCredential.user.email);
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState());
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signUp({String email, String password}) async {
    emit(SignUpLoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.user.email);
      if (userCredential.user.email != null) {
        emit(SignUpSuccessState());
      }
    } on FirebaseAuthException catch (e) {
      emit(SignUpErrorState());
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      emit(SignUpSuccessState());
      print(e);
    }
  }

  UserCredential user;
  Future<dynamic> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    user = await _auth.signInWithCredential(credential);
    if (user.user.displayName != null) {
      emit(LoginSuccessState());
    }
  }

  Future<void> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      emit(LoginSuccessState());
      final AccessToken accessToken = result.accessToken;
      print(result.accessToken);
      print('success facebook login');
    } else {
      print(result.status);
      print(result.message);
    }
  }
}
