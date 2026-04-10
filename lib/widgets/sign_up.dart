import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_music/bloc/authentication/bloc.dart';
import 'package:flutter_music/utils/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';


class SignUp extends StatefulWidget {
  const SignUp({ super.key });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final AuthenticationBloc authenticationBloc = context.read<AuthenticationBloc>();

  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: context.width * (context.isPhone ? 0.75 : 0.5),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                    top: 50,
                    bottom: 25
                ),
                child: FormBuilder(
                    key: _formKey,
                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      buildWhen: (previous, current) =>
                      previous.logUpIsLoading != current.logUpIsLoading,
                      builder: (_, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FormBuilderTextField(
                              // key: _emailFieldKey,
                              name: 'first_name',
                              enabled: !state.logUpIsLoading,
                              decoration: const InputDecoration(
                                labelText: 'Nombre',
                                errorStyle: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.lightSixColor,
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              // key: _emailFieldKey,
                              name: 'last_name',
                              enabled: !state.logUpIsLoading,
                              decoration: const InputDecoration(
                                labelText: 'Apellido',
                                errorStyle: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.lightSixColor,
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              // key: _emailFieldKey,
                              name: 'email',
                              enabled: !state.logUpIsLoading,
                              decoration: const InputDecoration(
                                labelText: 'Correo electrónico',
                                errorStyle: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.lightSixColor,
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ]),
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'password1',
                              enabled: !state.logUpIsLoading,
                              decoration: InputDecoration(
                                labelText: 'Contraseña',
                                errorStyle: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.lightSixColor,
                                ),
                                suffixIcon: Semantics(
                                  label: _obscureText ? 'Mostrar contraseña' : 'Ocultar contraseña',
                                  container: true,
                                  button: true,
                                  excludeSemantics: true,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              obscureText: _obscureText,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                    (String? val) {
                                  String? password2 = _formKey.currentState?.value['password2'];

                                  if (password2 == null) return null;
                                  if (val != password2) return 'Las contraseñas no coinciden.';

                                  return null;
                                },
                              ]),
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'password2',
                              enabled: !state.logUpIsLoading,
                              decoration: InputDecoration(
                                labelText: 'Repetir contraseña',
                                errorStyle: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.lightSixColor,
                                ),
                                suffixIcon: Semantics(
                                  label: _obscureText ? 'Mostrar contraseña' : 'Ocultar contraseña',
                                  container: true,
                                  button: true,
                                  excludeSemantics: true,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              obscureText: _obscureText,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                    (String? val) {
                                  String? password1 = _formKey.currentState?.value['password1'];

                                  if (password1 == null) return null;
                                  if (val != password1) return 'Las contraseñas no coinciden.';

                                  return null;
                                },
                              ]),
                            ),
                            const SizedBox(height: 25),
                            (!state.logUpIsLoading && !state.isLogged) ?
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  child: const Text('Crear cuenta'),
                                  onPressed: () {
                                    bool? isValid = _formKey
                                        .currentState
                                        ?.saveAndValidate(
                                        focusOnInvalid: false);

                                    if (!isValid!) return;

                                    String email = _formKey.currentState?.value['email'] ??  '';
                                    String password = _formKey.currentState?.value['password1'] ?? '';
                                    String firstName = _formKey.currentState?.value['first_name'] ?? '';
                                    String lastName = _formKey.currentState?.value['last_name'] ?? '';

                                    authenticationBloc.add(
                                        SignUpEvent(
                                          email: email,
                                          username: email,
                                          password: password,
                                          firstName: firstName,
                                          lastName: lastName,
                                          afterSuccess: () async {
                                            Navigator.pop<bool>(context, true);

                                            ScaffoldMessenger
                                                .of(context)
                                                .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                      '¡Cuenta creada con éxito! Ahora estamos iniciando sesión por ti.'
                                                  ),
                                                  // backgroundColor: AppTheme.lightSecondaryColor,
                                                )
                                            );
                                            authenticationBloc.add(SignInEvent(
                                              email: email,
                                              password: password,
                                              rememberMe: true,
                                            ));
                                          },
                                          afterError: (e) {
                                            ScaffoldMessenger
                                                .of(context)
                                                .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      e.response?.data['message'] ?? '¡Error al crear la cuenta!'
                                                  ),
                                                  // backgroundColor: AppTheme.lightSecondaryColor,
                                                )
                                            );
                                          },
                                        )
                                    );
                                  }
                              ),
                            ) : const SpinKitWave(
                              color: Colors.white,
                              type: SpinKitWaveType.center,
                            ),
                          ],
                        );
                      },
                    )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ExcludeSemantics(
                    child: Text(
                      '¿Ya tienes una cuenta?',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.lightSixColor,
                      ),
                    ),
                  ),
                  Semantics(
                    label: '¿Ya tienes una cuenta? Inicia sesión',
                    slider: true,
                    excludeSemantics: true,
                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        buildWhen: (previous, current) =>
                        previous.logUpIsLoading != current.logUpIsLoading,
                        builder: (_, state) {
                          return TextButton(
                            onPressed: !state.logUpIsLoading ? () {
                              Get.back();
                            } : null,
                            child: const Text(
                              'Inicia sesión',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.lightFiveColor,
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
