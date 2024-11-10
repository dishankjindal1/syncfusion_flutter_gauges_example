import 'package:flutter/material.dart';
import 'package:pulgas_power/flow/view/pages/live_page/live_page.dart';

class PPLoginPage extends StatefulWidget {
  const PPLoginPage({super.key});

  static pushReplacement(final BuildContext context) {
    Navigator.pushReplacement(context,
        PageRouteBuilder(pageBuilder: (context, a, b) {
      return const PPLoginPage();
    }));
  }

  @override
  State<PPLoginPage> createState() => _PPLoginPageState();
}

class _PPLoginPageState extends State<PPLoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Check if authorized or not
    // PPLivePage.pushReplacement(context);
  }

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
                              hintText: 'Email',
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
                            onSaved: (emailAddress) {
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
                                    horizontal: 16.0 * 1.5, vertical: 16.0),
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
                                PPLivePage.pushReplacement(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 48),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text("Sign in"),
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
