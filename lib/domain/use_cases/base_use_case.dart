abstract class BaseUseCase<Input, Output> {
  Output execute(Input input);
}

abstract class FutureBaseUseCase<Input, Output> {
  Future<Output> execute(Input input);
}

class NoParams {
  const NoParams();
}
