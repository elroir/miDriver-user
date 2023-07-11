abstract class HttpPostStatus {

  final String message;

  HttpPostStatus({
    this.message = '',
  });
}

class HttpPostStatusNone extends HttpPostStatus{}

class HttpPostStatusLoading extends HttpPostStatus{
  HttpPostStatusLoading({super.message});
}

class HttpPostStatusSuccess extends HttpPostStatus{
  HttpPostStatusSuccess({super.message});
}

class HttpPostStatusError extends HttpPostStatus{
  HttpPostStatusError({required super.message});
}