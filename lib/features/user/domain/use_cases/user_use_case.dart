
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_model.dart';
import 'package:dartz/dartz.dart';

 class UserUseCase implements UseCase<UserModel, NoParams> {
 
     @override
     Future<Either<Failure, UserModel>> call(NoParams params) {
    // TODO: implement call
     throw UnimplementedError();
     }


}