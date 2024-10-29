import 'dart:convert';

import 'package:flagsmith/flagsmith.dart';

class ConfigService {
  static const _apikey = 'Ew7V82L7oNvt79kmV5HeK6';

  late final FlagsmithClient _flagsmithClient;

  late final String _link;
  late final bool _useMock;
  late final String _target;

  Future<ConfigService> init() async {

    _flagsmithClient = await FlagsmithClient.init(
      apiKey: _apikey,
      config: const FlagsmithConfig(
        caches: true,
      ),
    );
    
    await _flagsmithClient.getFeatureFlags(reload: true);

    final config = jsonDecode(
        await _flagsmithClient.getFeatureFlagValue(ConfigKey.config.name) ??
            '') as Map<String, dynamic>;

    _link = config[ConfigKey.link.name];
    _useMock = config[ConfigKey.useMock.name];
    _target = config[ConfigKey.target.name];
    return this;
  }

  void closeClient() => _flagsmithClient.close();

  bool get useMock => _useMock;

  String get link => _link;

  String get target => _target;
}

enum ConfigKey {
  config,
  link,
  useMock,
  target
}