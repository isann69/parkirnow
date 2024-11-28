import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();  // GlobalKey untuk Form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Menangani status loading

  // Validasi email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    // Validasi format email menggunakan regular expression
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validasi password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    // Validasi panjang password minimal 6 karakter
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Fungsi untuk menangani login (simulasi)
  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Mengubah status loading saat proses login
      });

      // Simulasi proses login, bisa diganti dengan autentikasi nyata
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false; // Mengubah status loading menjadi false setelah selesai
        });

        // Menampilkan pesan sukses menggunakan SnackBar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Successful'),
        ));

        // Di sini Anda bisa menambahkan logika autentikasi nyata
        print("Email: ${_emailController.text}");
        print("Password: ${_passwordController.text}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Key untuk form
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Input Email
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            
          ),
          SizedBox(height: 16), // Jarak antar elemen

          // Input Password
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            obscureText: true, // Menyembunyikan teks password
            validator: _validatePassword,
          ),
          SizedBox(height: 40), // Jarak antar elemen

          // Tombol Login
          ElevatedButton(
            onPressed: _isLoading ? null : _login,  // Menonaktifkan tombol saat loading
            child: _isLoading 
                ? CircularProgressIndicator(color: Colors.black)  // Menampilkan spinner saat loading
                : Text('Login'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14),
              minimumSize: Size(double.infinity, 50),  // Tombol memenuhi lebar layar
            ),
          ),
        ],
      ),
    );
  }
}
