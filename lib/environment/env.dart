import 'env_dev.dart';

enum Environment { DEV, PROD }

class Env {
  static Map<String, dynamic> config;
  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        config = EnvDev.devConfig;
        break;
    }
  }

  static get ENV {
    return config['ENV'];
  }

  static get API_URL {
    return config['API_URL'];
  }

}
