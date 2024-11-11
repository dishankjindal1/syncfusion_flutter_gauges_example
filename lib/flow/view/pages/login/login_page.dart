import 'package:flutter/material.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/flow/view/app.dart';

class PPLoginPage extends StatelessWidget with AppStorageMixin {
  const PPLoginPage({super.key});

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(children: [
            TextSpan(text: 'Pulgas'),
            TextSpan(
              text: 'Power',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
          style: TextStyle(fontSize: 24),
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
                    SizedBox(height: constraints.maxHeight * 0.2),
                    Form(
                      key: _formKey,
                      child: Column(
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
                            onSaved: (username) {
                              // Save it
                            },
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
                              onSaved: (passaword) {
                                // Save it
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                getRef<AuthData>()
                                  ..aKey = 'authorized'
                                  ..save();
                                PPMain.pushReplacement(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 48),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('Sign in'),
                          ),
                        ],
                      ),
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
