import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:flutter/widgets.dart';

 

class Register extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Perform login action
      final email = _emailController.text;
      final password = _passwordController.text;

      // Placeholder for login logic
      print('Email: $email');
      print('Password: $password');

      // Navigate to MyHomePage after login
      Navigator.pushReplacementNamed(context, '/home');

      // Display a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logging in...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.black38,
        centerTitle: true, 
       ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/image.png', // Replace with your background image
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                       
                      controller: _emailController,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Basic email validation
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      style: TextStyle(fontSize: 18.0),
                      
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),

                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                        
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 22.0),
                    ElevatedButton(
                      onPressed: _login,
                      style: ButtonStyle(
                         
                        backgroundColor:  MaterialStateProperty.all<Color>(Color.fromARGB(255, 163, 236, 247)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.all(16.0), // Set padding for all states
                            ),
                      ),
                      
                      child: Text('Register'),
                    ),

                     Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You have an account?",
                      style: TextStyle(
                        color: Colors.amber[50]
                      ),),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                                (route) => false,
                          );
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
