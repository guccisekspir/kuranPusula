import 'package:get_it/get_it.dart';
import 'package:kuranpusula/blocs/beadsBloc/bloc/beads_bloc.dart';
import 'package:kuranpusula/data/favoritesApiClient.dart';
import 'package:kuranpusula/data/hiveApiClient.dart';
import 'package:kuranpusula/data/hiveRepository.dart';

GetIt getIt = GetIt.instance;

setupLocator() {
  getIt.registerLazySingleton<HiveRepository>(() => HiveRepository());
  getIt.registerLazySingleton<HiveApiClient>(() => HiveApiClient());

  getIt.registerLazySingleton<FavoritesApiClient>(() => FavoritesApiClient());

  getIt.registerLazySingleton<BeadsBloc>(() => BeadsBloc());
}
