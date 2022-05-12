import 'package:get_it/get_it.dart';
import 'package:kuranpusula/blocs/beadsBloc/bloc/beads_bloc.dart';
import 'package:kuranpusula/blocs/quranBloc/bloc/quran_bloc.dart';
import 'package:kuranpusula/data/favoritesApiClient.dart';
import 'package:kuranpusula/data/hiveApiClient.dart';
import 'package:kuranpusula/data/hiveRepository.dart';
import 'package:kuranpusula/data/quranApiClient.dart';
import 'package:kuranpusula/data/quranRepository.dart';

GetIt getIt = GetIt.instance;

setupLocator() {
  getIt.registerLazySingleton<HiveRepository>(() => HiveRepository());
  getIt.registerLazySingleton<HiveApiClient>(() => HiveApiClient());

  getIt.registerLazySingleton<QuranRepository>(() => QuranRepository());
  getIt.registerLazySingleton<QuranApiClient>(() => QuranApiClient());

  getIt.registerLazySingleton<FavoritesApiClient>(() => FavoritesApiClient());

  getIt.registerLazySingleton<BeadsBloc>(() => BeadsBloc());
  getIt.registerLazySingleton<QuranBloc>(() => QuranBloc());
}
