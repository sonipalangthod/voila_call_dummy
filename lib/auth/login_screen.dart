import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dashboard_screen.dart';
import 'database_helper.dart';
import 'package:voila_call_dummy/auth//register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF5E17EB), // Apply theme color to app bar
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE7E7E7), // Light grey
              Colors.white, // White
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5E17EB), // Apply theme color to text
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(
                    FontAwesomeIcons.user,
                    size: 18,
                    color: Color(0xFF5E17EB), // Apply theme color to icon
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(
                    FontAwesomeIcons.lock,
                    size: 18,
                    color: Color(0xFF5E17EB), // Apply theme color to icon
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xFF5E17EB), // Apply theme color to icon
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    String username = usernameController.text;
                    String password = passwordController.text;

                    if (await _checkCredentials(username, password)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(username: ''),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Invalid username or password.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5E17EB), // Apply theme color to text
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Color(0xFF5E17EB)),
                  ),
                ),
              ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(userCredentials: {}),
                      ),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5E17EB), // Apply theme color to text
                    ),
                  ),
                  style: ButtonStyle(

                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Apply theme color as border color
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Color(0xFF5E17EB)), // Remove overlay color
                  ),
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _checkCredentials(String username, String password) async {
    List<Map<String, dynamic>> users = await DatabaseHelper.getUsers();
    for (var user in users) {
      if (user['username'] == username && user['password'] == password) {
        return true;
      }
    }
    return false;
  }
}
