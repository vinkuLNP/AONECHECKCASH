import 'package:a1_check_cashers/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:a1_check_cashers/features/auth/domain/repositories/auth_repository.dart';
import 'package:a1_check_cashers/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:a1_check_cashers/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:a1_check_cashers/features/profile/domain/repository/profile_repository.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/delete_user_usecase.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/update_id_usecase.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/upload_business_form_usecase.dart';
import 'package:a1_check_cashers/features/profile/domain/usecases/upload_id_usecase.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/business_check_provider.dart';
import 'package:a1_check_cashers/features/profile/presentation/provider/profile_provider.dart';
import 'package:a1_check_cashers/features/cheque/data/data_sources/upload_remote_data_source.dart';
import 'package:a1_check_cashers/features/cheque/data/repositories/upload_repository_imp.dart';
import 'package:a1_check_cashers/features/cheque/domain/repositories/upload_repository.dart';
import 'package:a1_check_cashers/features/cheque/domain/usecases/create_cheque_usecase.dart';
import 'package:a1_check_cashers/features/cheque/domain/usecases/fetch_cheques_usecase.dart';
import 'package:a1_check_cashers/features/cheque/domain/usecases/update_cheque_usecase.dart';
import 'package:a1_check_cashers/features/cheque/presentation/provider/cheque_provider.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/presentation/provider/auth_provider.dart';
import '../../features/cheque/domain/usecases/upload_image_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => AuthRemoteDataSource());
  sl.registerLazySingleton(() => UploadRemoteDataSource());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<UploadRepository>(() => UploadRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));

  sl.registerLazySingleton(() => UploadImageUseCase(sl()));
  sl.registerLazySingleton(() => FetchChequesUseCase(sl()));
  sl.registerLazySingleton(() => UpdateChequeUsecase(sl()));
  sl.registerLazySingleton(() => CreateChequeUsecase(sl()));

  sl.registerLazySingleton(() => UploadBusinessFormUsecase(sl()));
  sl.registerLazySingleton(() => FetchBusinessFormUsecase(sl()));
  sl.registerLazySingleton(() => CreateBusinessFormUsecase(sl()));
  sl.registerLazySingleton(() => UpdateBusinessFormUsecase(sl()));
  sl.registerLazySingleton(() => DownloadEmptyFormUsecase(sl()));
  sl.registerFactory(
    () => BusinessCheckProvider(
      uploadUsecase: sl(),
      updateUsecase: sl(),
      createUsecase: sl(),
      fetchUsecase: sl(),
      downloadUsecase: sl(),
    ),
  );
  sl.registerFactory(() => AuthProvider(sl(), sl()));
  sl.registerFactory(
    () => ChequeFormProvider(
      uploadImageUseCase: sl(),
      createChequeUsecase: sl(),
      updateChequeUsecase: sl(),
      fetchCheques: sl(),
    ),
  );

  sl.registerLazySingleton(() => ProfileRemoteDataSource());

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UploadIdUseCase(sl()));
  sl.registerLazySingleton(() => UpdateIdUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));


  sl.registerFactory(
    () => ProfileProvider(getProfile: sl(), uploadId: sl(), updateId: sl(), deleteUser: sl()),
  );
  // sl.registerFactory(() => DrawerProvider());
}
