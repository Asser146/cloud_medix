import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reserve_status_state.dart';

class ReserveStatusCubit extends Cubit<ReserveStatusState> {
  ReserveStatusCubit() : super(const ReserveStatusInitial());
  bool selected = false;

  void toggleSlot() {
    emit(const ReserveStatusInitial());
    selected = !selected;
    emit(ReserveStatusToggled(selected));
  }
}
