import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/auth_service.dart';
import 'package:timetrack/screens/common_screens/widgets/app_bar_widget.dart';

import '../../../data/remote/firebase/firestore_service.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final firestoreService = FirestoreService();
    return FutureBuilder(
      future: firestoreService.getUser(auth.currentUser!.uid),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final user = snap.data!;t
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBarWidget(isCheck: false, name: user.hoTen),
        );
      },
    );
  }
}
