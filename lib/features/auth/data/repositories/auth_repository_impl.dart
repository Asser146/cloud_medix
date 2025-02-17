import 'package:cloud_medix/features/auth/domain/repositories/auth_repository.dart';
import 'package:cloud_medix/features/auth/data/data_sources/auth_data_source.dart';



/// AuthRepositoryImpl is the concrete implementation of the AuthRepository
/// interface.
/// This class implements the methods defined in AuthRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class AuthRepositoryImpl implements AuthRepository {
      
   final AuthDataSource  authDataSource;
   AuthRepositoryImpl(this.authDataSource);
}