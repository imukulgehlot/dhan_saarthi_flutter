import 'base_config.dart';
import 'build_config.dart';

class Environment {
  static final Environment _instance = Environment._();

  Environment._();

  factory Environment() {
    return _instance;
  }

  static late BaseConfig config;

  initConfig(String environment) {
    config = _configMap[environment] ?? DevConfig();

    // Configuring Amplify
    // CognitoHelpingHand.configureAmplify(environment: environment);
  }

  static const String development = 'DEV';
  static const String staging = 'STAGING';
  static const String production = 'PROD';

  final Map<String, BaseConfig> _configMap = {
    Environment.production: ProdConfig(),
    Environment.staging: StagingConfig(),
    Environment.development: DevConfig()
  };
}
