import 'package:bloc/bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'editar_event.dart';
part 'editar_state.dart';
part 'editar_bloc.freezed.dart';

class EditarBloc extends Bloc<EditarEvent, EditarState> {
  EditarBloc() : super(const Initial()) {
    on<EditarEvent>((event, emit)  async{
       emit(state.when(
         initial: () => const EditarState.runing(true),
         runing:(visi)=> event.when(
        mostrar: ()=> EditarState.runing(!visi)),   
        )
       );     
     }
    ); 
  }
}
