import 'package:get_it/get_it.dart';
import '../features/access_requests/state/access_requests_state.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AccessRequestsState>(AccessRequestsState());
}
