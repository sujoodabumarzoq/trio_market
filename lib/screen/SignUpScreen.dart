import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/auth_repository.dart';
import 'package:trio_market/cubit/signup/signup_cubit.dart';

class SignUpScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedRole;

  SignUpScreen({super.key});

  // دالة للتحقق من صيغة الإيميل
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // دالة للتحقق من البيانات
  String? _validateInputs(String name, String email, String password, String phone, String? role) {
    if (name.isEmpty || name.length < 3) {
      return 'الاسم مطلوب ويجب أن يكون 3 أحرف على الأقل';
    }
    if (!_isValidEmail(email)) {
      return 'يرجى إدخال بريد إلكتروني صالح (مثل user@domain.com)';
    }
    if (password.isEmpty || password.length < 6) {
      return 'كلمة المرور مطلوبة ويجب أن تكون 6 أحرف على الأقل';
    }
    if (phone.isEmpty || phone.length < 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
      return 'رقم الهاتف مطلوب ويجب أن يكون 10 أرقام على الأقل وأرقام فقط';
    }
    if (role == null) {
      return 'يرجى اختيار دور';
    }
    return null; // كل البيانات صالحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        title: const Text('إنشاء حساب', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider(
          create: (context) => SignUpCubit(AuthRepository()),
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                String route;
                switch (_selectedRole) {
                  case 'مشتري':
                    route = '/buyer_home';
                    break;
                  case 'بائع':
                    route = '/seller_home';
                    break;
                  case 'ديلفري':
                    route = '/delivery_home';
                    break;
                  default:
                    route = '/home';
                }
                Navigator.pushReplacementNamed(context, route);
              } else if (state is SignUpFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'الاسم',
                        prefixIcon: const Icon(Icons.person, color: Color(0xFF1976D2)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        prefixIcon: const Icon(Icons.email, color: Color(0xFF1976D2)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        prefixIcon: const Icon(Icons.lock, color: Color(0xFF1976D2)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'رقم الهاتف',
                        prefixIcon: const Icon(Icons.phone, color: Color(0xFF1976D2)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      hint: const Text('اختر دورك'),
                      items: ['مشتري', 'بائع', 'ديلفري']
                          .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                          .toList(),
                      onChanged: (value) {
                        _selectedRole = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state is SignUpLoading
                          ? null
                          : () {
                        final validationError = _validateInputs(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _phoneController.text,
                          _selectedRole,
                        );
                        if (validationError != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(validationError)),
                          );
                        } else {
                          print('Sending from Screen: name=${_nameController.text}'); // تحقق من الاسم
                          context.read<SignUpCubit>().signUp(
                            _nameController.text,
                            _emailController.text,
                            _passwordController.text,
                            _phoneController.text,
                            _selectedRole!,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(state is SignUpLoading ? 'جاري التسجيل...' : 'إنشاء الحساب'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}