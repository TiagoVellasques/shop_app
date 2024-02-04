import 'package:firebase_remote_config/firebase_remote_config.dart';

// class RemoteConfigService {
//   final RemoteConfig _remoteConfig;

//   RemoteConfigService({required RemoteConfig remoteConfig})
//       : _remoteConfig = remoteConfig;

//   // Future<void> initialize() async {
//   //   try {
//   //     await _remoteConfig.fetch();
//   //     await _remoteConfig.activateFetched();
//   //   } catch (e) {
//   //     print('Erro ao inicializar o Remote Config: $e');
//   //   }
//   // }

//   Future initialise() async {
//     const String _ShowMainBanner = "grid_view";
//     final defaults = <String, dynamic>{_ShowMainBanner: false};
//     try {
//       await _remoteConfig.setDefaults(defaults);
//       await _fetchAndActivate();
//     } on FetchThrottledException catch (exception) {
//       // Fetch throttled.
//       print('Remote config fetch throttled: $exception');
//     } catch (exception) {
//       print('Unable to fetch remote config. Cached or default values will be '
//           'used');
//     }
//   }

//   Future _fetchAndActivate() async {
//     await _remoteConfig.fetch();
//     await _remoteConfig.activateFetched();
//   }

//   // String getVarianteDoTeste() {
//   //   return _remoteConfig.getString('variante_do_testeAB');
//   // }
// }

