import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_with_bloc/dependencies_injection.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/domain/use_cases/login.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:flutter_clean_architecture_with_bloc/features/auth/presentation/widgets/form_field.dart';
import 'package:flutter_clean_architecture_with_bloc/features/users/presentation/pages/users_page.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/extension/strings.dart';
import 'package:flutter_clean_architecture_with_bloc/utils/extension/text_theme.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  /// Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// Global key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is AuthSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const UsersPage()));
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<AuthCubit, AuthState>(
            builder: bodySection,
          ),
        ),
      ),
    );
  }

  /// Body
  Padding bodySection(BuildContext context, AuthState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Admin', style: Theme.of(context).textTheme.titleTextStyle),
                const SizedBox(height: 5),
                Text('Clean Architecture with Bloc', style: Theme.of(context).textTheme.subtitleTextStyle),
              ],
            ),
            Column(
              children: [
                customFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  obscureText: false,
                  validator: (String? value) => value != null ? (!value.isValidEmail() ? 'Invalid email' : null) : null,
                  key: 'email',
                  isSuffixIcon: false,
                  suffixIcon: null,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'eve.holt@reqres.in',
                ),
                const SizedBox(height: 20),
                customFormField(
                  controller: _passwordController,
                  labelText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: context.read<AuthCubit>().isPasswordHide,
                  validator: (String? value) => value != null ? (value.length < 6 ? 'Password too short' : null) : null,
                  key: 'password',
                  isSuffixIcon: true,
                  suffixIcon: IconButton(
                    onPressed: () => context.read<AuthCubit>().showHidePassword(),
                    icon: Icon(
                      (context.read<AuthCubit>().isPasswordHide) ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black26,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  hintText: 'cityslicka',
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Text('Forget password?', style: Theme.of(context).textTheme.textHintStyle),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: state is AuthLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().login(
                                    LoginParams(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text('Login', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
