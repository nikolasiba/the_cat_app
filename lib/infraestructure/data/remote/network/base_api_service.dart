abstract class BaseApiService {
  Future<dynamic> getResponse(String url);
  Future<dynamic> postResponse(String url, Object jsonBody,
      {Map<String, String> headers = const {}});
}
