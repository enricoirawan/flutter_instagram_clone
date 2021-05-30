part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [];
}

class AuthUserChanges extends AuthEvent {
  final auth.User user;

  const AuthUserChanges({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthLogoutRequested extends AuthEvent {}
