import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/core/theme/theme.dart';
import 'package:pulgas_power/flow/view/app.dart';

class PPLoginPage extends StatelessWidget with AppStorageMixin {
  const PPLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(PPTheme.appBgColor),
      appBar: AppBar(
        backgroundColor: const Color(PPTheme.appBarColor),
        centerTitle: false,
        title: const Text.rich(
          TextSpan(children: [
            TextSpan(text: 'Pulgas'),
            TextSpan(
              text: 'Power',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
          style: TextStyle(
            color: Color(PPTheme.appBarHeaderColor),
            fontSize: 24,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Column(
                  children: [
                    Gap(constraints.maxHeight * 0.2),
                    Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            filled: true,
                            fillColor: Color(0xFFF5FCF9),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              filled: true,
                              fillColor: Color(0xFFF5FCF9),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5,
                                vertical: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            getRef<AuthData>()
                              ..aKey = 'authorized'
                              ..save();
                            PPMain.pushReplacement(context);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 48),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
