abstract class HttpPostStatus<T> {

  final String message;
  final T? data;

  HttpPostStatus({
    this.message = '',
    this.data
  });
}

class HttpPostStatusNone<T> extends HttpPostStatus<T>{}

class HttpPostStatusLoading<T> extends HttpPostStatus<T>{
  HttpPostStatusLoading({super.message});
}

class HttpPostStatusSuccess<T> extends HttpPostStatus<T>{
  HttpPostStatusSuccess({super.message,super.data});
}

class HttpPostStatusError<T> extends HttpPostStatus<T>{
  HttpPostStatusError({required super.message});
}

class HttpPostStatusAuthorization<T> extends HttpPostStatus<T>{
  HttpPostStatusAuthorization({required super.message});
}