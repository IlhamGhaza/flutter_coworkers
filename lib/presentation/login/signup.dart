import 'package:flutter/material.dart';
import 'package:flutter_coworkers/presentation/login/widget/input_auth.dart';

import '../../config/assets/assets.gen.dart';
import '../../config/extension/route_ext.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  Assets.images.signinBackground.path,
                  fit: BoxFit.cover,
                ),
                Center(
                  child: Image.asset(
                    Assets.images.applogo.path,
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: Transform.translate(
                    offset: const Offset(0, 10),
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'New Account',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13162f),
                          ),
                        ),
                        Text(
                          'Lest grow your business',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffa7a8b3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 20,
              children: [
                InputAuth(
                  editingController: _nameController,
                  labelText: 'Input your name',
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                InputAuth(
                  editingController: _emailController,
                  labelText: 'Input your email',
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                InputAuth(
                  editingController: _passwordController,
                  labelText: 'Input your password',
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                InputAuth(
                  editingController: _confirmPasswordController,
                  labelText: 'Confirm your password',
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  confirmPasswordController: _passwordController,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Proses signup
                      print('Form is valid. Processing signup...');
                    }
                  },
                  child: Text('Sign Up'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteExt.login.name);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign Up",
                        ),
                        ImageIcon(
                          AssetImage(Assets.images.icWhiteArrowRight.path),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
