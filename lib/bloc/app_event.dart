// part of 'app_bloc.dart';
part of searching;

@immutable
abstract class AppEvent {}

class ReloadEvent extends AppEvent{}

class LoadingEvent extends AppEvent{} 