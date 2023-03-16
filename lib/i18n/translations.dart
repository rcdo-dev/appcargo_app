abstract class Translations {
  String get appName;
  String get language;

  String get alertNewAccount;
  String get alertNewAccountDescription;

  String get actionWannaSignUp;
  String get actionMaybeLater;
}

class PortugueseTranslations implements Translations {
  String get appName => "AppCargo";
  String get language => "Português";

  String get alertNewAccount => "Nova Conta";
  String get alertNewAccountDescription  => "Para agilizar, esteja perto do seu caminhão e com seus documentos em mãos!";

  String get actionWannaSignUp => "Quero me cadastrar";
  String get actionMaybeLater => "Mais tarde";
}

class EnglishTranslations implements Translations {
  String get appName => "AppCargo";
  String get language => "English";

  String get alertNewAccount => "New Account";
  String get alertNewAccountDescription  => "Be sure to be close to your truck and have your documents at hand!";

  String get actionWannaSignUp => "I want to signup!";
  String get actionMaybeLater => "Maybe later";
}
