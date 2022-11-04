part of 'editar_bloc.dart';

@freezed
class EditarState with _$EditarState {
  const factory EditarState.initial() = Initial;
  const factory EditarState.runing(bool visi)= Running;
}
