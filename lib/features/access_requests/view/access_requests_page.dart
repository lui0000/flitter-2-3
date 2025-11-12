import 'package:flutter/material.dart';
import '../stores/access_requests_store.dart';
import 'access_requests_view.dart';

class AccessRequestsPage extends StatelessWidget {
  const AccessRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AccessRequestsStore();
    return AccessRequestsView(store: store);
  }
}
