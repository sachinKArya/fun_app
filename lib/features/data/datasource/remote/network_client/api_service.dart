import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '/')
abstract class ApiService extends ChopperService {
  @Get(path: '/api?format=json')
  Future<Response> getJoke();

  static ApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: Uri.parse("https://geek-jokes.sameerkumar.website"),
      services: [_$ApiService()],
    );

    // The generated class with the ChopperClient passed in
    return _$ApiService(client);
  }
}
