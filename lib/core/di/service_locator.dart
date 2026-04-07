import 'package:a1_check_cashers/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:a1_check_cashers/features/auth/domain/repositories/auth_repository.dart';
import 'package:a1_check_cashers/features/drawer/presentation/provider/drawer_provider.dart';
import 'package:a1_check_cashers/features/upload_image/data/data_sources/upload_remote_data_source.dart';
import 'package:a1_check_cashers/features/upload_image/data/repositories/upload_repository_imp.dart';
import 'package:a1_check_cashers/features/upload_image/domain/repositories/upload_repository.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/presentation/provider/auth_provider.dart';
import '../../features/upload_image/domain/usecases/upload_image_usecase.dart';
import '../../features/upload_image/domain/usecases/create_document_usecase.dart';
import '../../features/upload_image/domain/usecases/fetch_document_usecase.dart';
import '../../features/upload_image/presentation/provider/upload_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => AuthRemoteDataSource());
  sl.registerLazySingleton(() => UploadRemoteDataSource());
 sl.registerLazySingleton<AuthRepository>(
  () => AuthRepositoryImpl(sl()),
);
sl.registerLazySingleton<UploadRepository>(
  () => UploadRepositoryImpl(sl()),
);
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));

  sl.registerLazySingleton(() => UploadImageUseCase(sl()));
  sl.registerLazySingleton(() => CreateDocumentUseCase(sl()));
  sl.registerLazySingleton(() => FetchDocumentsUseCase(sl()));
  sl.registerFactory(
    () => AuthProvider(sl(), sl()),
  );

  sl.registerFactory(
    () => UploadProvider(
      uploadImage: sl(),
      createDoc: sl(),
      fetchDocs: sl(),
    )..loadDocuments(),
  );

  sl.registerFactory(() => DrawerProvider());
}