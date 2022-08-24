// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'app_event.dart';
// part 'app_state.dart';

part of searching;

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<AppEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ReloadEvent>((event, emit) async {

      // print('test1');
      emit(LoadingState());
      await Future.delayed(Duration(seconds: 2));
      emit(ReloadState());
    }
    );
  }
 
  ReloadEventScreen() {

    
    add(ReloadEvent());



  }
}
