part of 'user_edit_cubit.dart';

abstract class EditUserState extends Equatable {
  const EditUserState();

  @override
  List<Object> get props => [];
}

class EditUserInitial extends EditUserState {}

class EditUserLoading extends EditUserState {}

class EditUserSuccess extends EditUserState {
  final String message;

  EditUserSuccess(this.message);
}

class EditUserFailed extends EditUserState {
  final String message;

  EditUserFailed(this.message);
}
