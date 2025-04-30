import 'package:exp/app_screens/Inventory.dart';
import 'package:exp/database/local/db_helper.dart';
import 'package:exp/model_classes/user_modelclass.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exp/database/local/db_helper.dart';
import '../model_classes/user_modelclass.dart';
import 'package:exp/provider/user_provider.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MaterialApp(
    home: AuthScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController(); // For registration name

  Future<bool> _authenticate() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (isLogin) {
        // LOGIN
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Inventory()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged in successfully')),
        );
        return true;
      } else {
        // REGISTER
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully')),
        );
        return true;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Authentication error')),
      );
      return false;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildTextField({
    required IconData icon,
    required String hintText,
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    bool _obscureText = isPassword;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          controller: controller,
          obscureText: _obscureText,
          style: const TextStyle(fontFamily: "Poppins"),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.green),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: "Poppins",
              fontStyle: FontStyle.italic,
            ),
            filled: true,
            fillColor: const Color(0xFFF8F8F8),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1.2),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(height: 40),
                  Text(
                    'Go ahead and set up\nyour account',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Sign in-up to enjoy the best managing experience',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Toggle Login/Register
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => setState(() => isLogin = true),
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: isLogin ? Colors.white : Colors.transparent,
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: isLogin ? Colors.black : Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => setState(() => isLogin = false),
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: !isLogin ? Colors.white : Colors.transparent,
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Register',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold,
                                                color: !isLogin ? Colors.black : Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Fields
                              if (isLogin) ...[
                                _buildTextField(icon: Icons.email, hintText: 'Email Address', controller: _emailController),
                                const SizedBox(height: 16),
                                _buildTextField(icon: Icons.lock, hintText: 'Password', isPassword: true, controller: _passwordController),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Checkbox(value: false, onChanged: (_) {}),
                                    const Text('Remember me', style: TextStyle(fontFamily: "Poppins")),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Forgot Password?', style: TextStyle(fontFamily: "Poppins", color: Colors.black)),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : () async {
                                      await _authenticate();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6E8C6D),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                      minimumSize: const Size(200, 70),
                                    ),
                                    child: _isLoading
                                        ? const CircularProgressIndicator(color: Colors.white)
                                        : const Text('Login', style: TextStyle(fontFamily: "Poppins", fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ] else ...[
                                _buildTextField(icon: Icons.person, hintText: 'Full Name', controller: _nameController),
                                const SizedBox(height: 16),
                                _buildTextField(icon: Icons.email, hintText: 'Email Address', controller: _emailController),
                                const SizedBox(height: 16),
                                _buildTextField(icon: Icons.lock, hintText: 'Password', isPassword: true, controller: _passwordController),
                                Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : () async {
                                      bool success = await _authenticate();
                                      if (success && !isLogin) {
                                        usermodel newuser = usermodel(
                                          name: _nameController.text,
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );
                                        try {
                                          await DbHelper.getinstance().insertuser(newuser);
                                          print("User registered successfully");

                                          // Fetch all users after registration and update UI
                                          await Provider.of<UserProvider>(context, listen: false).getUsers();
                                          print('All users: ${Provider.of<UserProvider>(context, listen: false).userList}');
                                        } catch (e) {
                                          print("Error registering user: $e");
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6E8C6D),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                      minimumSize: const Size(200, 70),
                                    ),
                                    child: _isLoading
                                        ? const CircularProgressIndicator(color: Colors.white)
                                        : const Text(
                                      'Register',
                                      style: TextStyle(fontFamily: "Poppins", fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                                    ),
                                  ),

                                ),
                              ],
                              const SizedBox(height: 14),
                              const Center(
                                child: Text(
                                  "Or login with",
                                  style: TextStyle(fontFamily: "Poppins", fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: Image.asset("assets/images/google.png", height: 24, width: 24),
                                      label: const Text("Google", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, color: Colors.black)),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(color: Color(0xFFF8F8F8)),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: Image.asset("assets/images/facebook.png", height: 30, width: 30),
                                      label: const Text("Facebook", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, color: Colors.black)),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(color: Color(0xFFF8F8F8)),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
