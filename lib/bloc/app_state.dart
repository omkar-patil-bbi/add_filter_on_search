// part of 'app_bloc.dart';
part of searching;

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class LoadingState extends AppState {}

class ReloadState extends AppState {}
 