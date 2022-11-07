import 'package:blog/bloc/editar_bloc.dart';
import 'package:flutter/cupertino.dart';


//if(state is Running || state is Initial)

 bool visibilidad(state) {
   if(state is Running){
     return state.visi;
   }
   else if (state is Initial) {
    return false;
   }else{
    return false;
   }
}