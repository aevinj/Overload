import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/classes/user.dart';
import 'package:progressive_overload/components/capitalise.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/main.dart';
import 'package:progressive_overload/util/box_manager.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boxManager = Provider.of<BoxManager>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Onboarding",
                    style: Font(color: Colors.black),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your name',
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      User user = User(name: _nameController.text.capitalise());

                      await boxManager.openUserBox();
                      await boxManager.saveUser(user);
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (builder) => const MyApp()));
                    },
                    child: const Text("Continue")),
              ],
            ),
          ),
        ));
  }
}
