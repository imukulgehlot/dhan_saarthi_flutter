import 'base_config.dart';
import 'environment.dart';

class DevConfig implements BaseConfig {
  @override
  String get apiHost => "https://dev-api.blabla.com/v1";

  @override
  String get environment => Environment.development;

  @override
  String get socketURL => "https://dev-socket.blabla.com";

  @override
  String get emoji => " 🛠️";
}

class StagingConfig implements BaseConfig {
  @override
  String get apiHost => "https://stag-api.blabla.com/v1";

  @override
  String get environment => Environment.staging;

  @override
  String get socketURL => "https://stag-socket.blabla.com";

  @override
  String get emoji => " 🚧";
}

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => "https://api.blabla.com/v1";

  @override
  String get environment => Environment.production;

  @override
  String get socketURL => "https://socket.blabla.com";

  @override
  String get emoji => " 🚀";
}
