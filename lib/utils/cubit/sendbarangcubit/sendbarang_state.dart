part of 'sendbarang_cubit.dart';

abstract class SendBarangState extends Equatable {
  const SendBarangState();

  @override
  List<Object> get props => [];
}

class SendBarangInitial extends SendBarangState {}

class SendBarangLoading extends SendBarangState {}

class SendBarangSuccess extends SendBarangState {
  final String message;

  SendBarangSuccess(this.message);
}

class SendBarangFailed extends SendBarangState {
  final String message;

  SendBarangFailed(this.message);
}

