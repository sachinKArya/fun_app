///Thrown when Http or API status is 5xx
class ServerException implements Exception {}

///Thrown when failed to fetch data from local DB or unable to store data to local DB
class LocalDBException implements Exception {}

///Thrown when Http status is 200 but API status is 4xx(except for 401)
class ServiceException implements Exception {}

///Thrown when Http status is 200 but API status is 4xx (except for 401) and API is returning appropriate error message
class APIServiceException implements Exception {
  String message;
  APIServiceException(this.message);
}
