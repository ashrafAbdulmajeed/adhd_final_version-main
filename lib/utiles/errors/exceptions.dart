class ServerException implements Exception {
  final String serverMessage;
  const ServerException(this.serverMessage);

  @override
  String toString() {
    return 'ServerException{serverMessage: $serverMessage}';
  }
}
