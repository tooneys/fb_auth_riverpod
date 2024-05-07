import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class ConfirmPasswordFormField extends StatelessWidget {
  const ConfirmPasswordFormField({
    super.key,
    required TextEditingController passwordController,
    required this.labelText,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        filled: true,
        labelText: labelText,
        prefixIcon: const Icon(Icons.lock),
      ),
      validator: (value) {
        if (_passwordController.text != value) {
          return '비밀번호와 일치하지 않습니다.';
        }
        return null;
      },
    );
  }
}

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    required TextEditingController passwordController,
    required this.labelText,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        filled: true,
        labelText: labelText,
        prefixIcon: const Icon(Icons.lock),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '비밀번호를 입력하시오.';
        }
        if (value.trim().length < 6) {
          return '비밀번호를 6자리 이상 입력하시오.';
        }
        return null;
      },
    );
  }
}

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        filled: true,
        labelText: 'Email',
        hintText: 'your@email.com',
        prefixIcon: Icon(Icons.email),
      ),
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return '이메일을 입력하시오.';
        }
        if (!isEmail(value.trim())) {
          return '이메일 형식이 맞지 않습니다.';
        }
        return null;
      },
    );
  }
}

class NameFormField extends StatelessWidget {
  const NameFormField({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        filled: true,
        labelText: '성명',
        prefixIcon: Icon(Icons.account_box),
      ),
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return '성명을 입력하시오.';
        }

        if (value.trim().length < 2 || value.trim().length > 12) {
          return '성명의 길이는 2글자 이상 12글자 미만으로 입력해주세요.';
        }

        return null;
      },
    );
  }
}
