part of 'reserve_status_cubit.dart';

sealed class ReserveStatusState extends Equatable {
  const ReserveStatusState();

  @override
  List<Object> get props => [];
}

final class ReserveStatusInitial extends ReserveStatusState {
  const ReserveStatusInitial();
}

final class ReserveStatusToggled extends ReserveStatusState {
  final bool selected;
  const ReserveStatusToggled(this.selected);
}
