late String baseUrl;
String umamiUrl = 'https://cloud.umami.is';

class Endpoints {
  static final String authLogin = '$baseUrl/api/auth/login';
  static final String websites = '$baseUrl/api/websites';
  static final String meTeams = '$baseUrl/api/me/teams';
  static String teamWebsites(String teamId) =>
      '$baseUrl/api/teams/$teamId/websites';
}
