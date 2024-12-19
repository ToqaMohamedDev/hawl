part of 'pay_cubit.dart';

@immutable
sealed class PayState {}

class PayInitial extends PayState {}

class PayLoading extends PayState {}

class PaySuccess extends PayState {
  final Map<String, dynamic> transferData;

  PaySuccess(this.transferData);
}

class PayFailure extends PayState {
  final String errorMessage;
  PayFailure(this.errorMessage);
}
