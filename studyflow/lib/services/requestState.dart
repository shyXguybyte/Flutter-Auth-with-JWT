enum RequestState {
  idle,
  loading,
  ok,
  serverFailure,
  internetFailure,
  error,
  unauthorized,
  emailAlreadyExist,
  userNotConfirm,
  invalidCredentials, badRequest,
  unexpectedError;
}