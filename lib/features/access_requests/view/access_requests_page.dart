import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/access_requests_cubit.dart';
import 'access_requests_view.dart';

class AccessRequestsPage extends StatelessWidget {
  const AccessRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccessRequestsCubit(),
      child: const AccessRequestsView(),
    );
  }
}
