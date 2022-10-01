import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/services/models.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    var user = AuthService().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UserInfo(user: user),
                UserProgress(report: report),
                const Spacer(),
                const SignOutButton(),
              ],
            )
          : const Text('No user signed in'),
    );
  }
}

class UserProgress extends StatelessWidget {
  const UserProgress({
    Key? key,
    required this.report,
  }) : super(key: key);

  final Report report;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Text(
            '🏆 ${report.total} Quizes completed',
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        child: const Text('Sign out'),
        onPressed: () async {
          await AuthService().signOut();
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        },
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 90,
          height: 90,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: user?.photoURL == null ? const AssetImage('assets/user.png') : NetworkImage(user?.photoURL ?? '') as ImageProvider),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.displayName ?? 'Guest',
                style: Theme.of(context).textTheme.headline5,
                overflow: TextOverflow.fade,
              ),
              user?.email != null
                  ? Text(
                      user?.email ?? '',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
