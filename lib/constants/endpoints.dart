class Endpoints {
  Endpoints._();

  static const String appWebsite = "http://appcargo.com.br";
  static const String appFacebook = "https://www.facebook.com/appcargobr/";
  static const String appInstagram = "https://www.instagram.com/appcargobr/";
  static const String appYoutube =
      "https://www.youtube.com/channel/UC4-vVWxpPn_kjwv-cym2DGA";
  static const String appTikTok =
      "https://www.tiktok.com/@appcargo?_t=8VGQbhV4xUc&_r=1";

  // static const String baseUrl = "http://192.168.0.198:8080";
  static const String baseUrl = "https://plataforma.appcargo.com.br";
  static const String chatBaseUrl = "https://chat.appcargo.com.br";

  // Modify the baseUrl to this address if you're running the app on the emulator
  // and the Spring Boot is running on your local machine.
  // static const String baseUrl = "http://10.0.2.2:8080";
  static const String mobileBaseUrl = baseUrl + "/mobile";
  static const String freightBaseUrl = chatBaseUrl + "/v1/users";

  static const String termsOfUse =
      "https://www.appcargo.com.br/termos_de_uso.html";
  static const String policyPrivacyUrl =
      "https://www.appcargo.com.br/politica_de_privacidade.html";
}
