import 'package:flutter/cupertino.dart';

import 'bloc/editar_bloc.dart';


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