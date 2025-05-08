import 'package:interview_test/core/result_types.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type>> execute(Params params);
}

class NoParams {}
