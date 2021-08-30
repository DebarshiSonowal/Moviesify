

import 'package:flutter_riverpod/all.dart';

class EnvironmentConfig{
  //'9cb713e96b94f71150aa6c1607db473d'
  //9cb713e96b94f71150aa6c1607db473d


  final APIKey = const String.fromEnvironment('movieApiKey');
  final apikeyaccesstoken = '9cb713e96b94f71150aa6c1607db473d';

}

final environmentConfig = Provider<EnvironmentConfig>((ref){
    return EnvironmentConfig();
});