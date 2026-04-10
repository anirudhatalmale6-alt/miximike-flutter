import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_music/bloc/authentication/bloc.dart';
import 'package:flutter_music/utils/theme.dart';
import 'package:flutter_music/widgets/sign_up.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscureText = true;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: FormBuilder(
                    key: _formKey,
                    child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      listenWhen: (previous, current) => current.isLogged != previous.isLogged,
                      listener: (context, state) {
                        Navigator.pop(context);
                      },
                      buildWhen: (previous, current) =>
                      previous.logInIsLoading != current.logInIsLoading,
                      builder: (_, state) {
                        final double width = context.width * (context.isPhone ? 1 : 0.5);

                        return SizedBox(
                          width: width,
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                // key: _emailFieldKey,
                                name: 'email',
                                enabled: !state.logInIsLoading,
                                decoration: const InputDecoration(
                                  labelText: 'Correo Electrónico',
                                  errorStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ]),
                              ),
                              const SizedBox(height: 10),
                              FormBuilderTextField(
                                name: 'password',
                                enabled: !state.logInIsLoading,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  errorStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  suffixIcon: Semantics(
                                    label: _obscureText ? 'Mostrar contraseña' : 'Ocultar contraseña',
                                    container: true,
                                    button: true,
                                    excludeSemantics: true,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.visibility,
                                        color: AppTheme.lightSecondaryColor,
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
                                ]),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () => _launchInBrowser(
                                    Uri(
                                        scheme: 'https',
                                        host: 'www.miximike.com',
                                        path: 'mi-cuenta/lost-password/'
                                    )
                                ),
                                child: const Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(
                                      "RECUPERAR CONTRASEÑA",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              (!state.logInIsLoading && !state.isLogged)
                                  ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: !state.logInIsLoading
                                      ? () {
                                    // Validate and save the form values
                                    bool? isValid = _formKey
                                        .currentState
                                        ?.saveAndValidate(
                                        focusOnInvalid: false
                                    );

                                    if (!isValid!) return;

                                    String email = _formKey.currentState
                                        ?.value['email'] ?? '';
                                    String password = _formKey
                                        .currentState
                                        ?.value['password'] ?? '';
                                    bool keepMeLoggedIn = _formKey
                                        .currentState
                                        ?.value['keepMeLoggedIn'] ?? false;

                                    context
                                        .read<AuthenticationBloc>()
                                        .add(SignInEvent(
                                        email: email,
                                        password: password,
                                        rememberMe: keepMeLoggedIn,
                                        afterSuccess: () {
                                          // AHORA LO HACEMOS EN EL LISTENER PARA QUE LO TOME TAMBIÉN EL CREAR CUENTA
                                          // Navigator.pop(context);
                                        },
                                        afterError: (e) => {
                                          ScaffoldMessenger
                                              .of(context)
                                              .showSnackBar(
                                              const SnackBar(
                                                content: Center(
                                                  child: Text(
                                                      '¡Correo electrónico o contraseña incorrecta!'
                                                  ),
                                                ),
                                                backgroundColor: AppTheme.lightSecondaryColor,
                                              )
                                          )
                                        }),
                                    );
                                  } : null,
                                  child: const Text('INICIAR SESIÓN'),
                                ),
                              ) : const SpinKitWave(
                                color: Colors.white,
                                type: SpinKitWaveType.center,
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Semantics(
                                      label: "¿Mantener sesión iniciada?",
                                      checked: true,
                                      excludeSemantics: true,
                                      child: FormBuilderCheckbox(
                                          name: "keepMeLoggedIn",
                                          initialValue: true,
                                          title: const Text(""),
                                          enabled: !state.logInIsLoading,
                                          decoration: InputDecoration(
                                            fillColor: Theme.of(context).primaryColor,
                                            contentPadding: const EdgeInsets.all(0),
                                          ),
                                          side: const BorderSide(
                                            color: Colors.white,
                                            width: 2.5,
                                          ),
                                          activeColor: AppTheme.lightSecondaryColor,
                                          contentPadding: EdgeInsets.zero,
                                          controlAffinity: ListTileControlAffinity.platform
                                      ),
                                    ),
                                  ),
                                  const ExcludeSemantics(
                                    child: Text(
                                      "¿MANTENER SESIÓN INICIADA?",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.075,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ExcludeSemantics(
                                    child: Text(
                                      '¿No tienes una cuenta?',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppTheme.lightSixColor,
                                      ),
                                    ),
                                  ),
                                  Semantics(
                                    label: '¿No tienes una cuenta? Crear cuenta',
                                    slider: true,
                                    excludeSemantics: true,
                                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                                        buildWhen: (previous, current) =>
                                        previous.logInIsLoading != current.logInIsLoading,
                                        builder: (_, state) {
                                          return TextButton(
                                            onPressed: !state.logInIsLoading ? () async {
                                              await showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (BuildContext context) => const FractionallySizedBox(
                                                  heightFactor: 0.85,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(20),
                                                        topRight: Radius.circular(20),
                                                      ),
                                                      child: SignUp()
                                                  ),
                                                ),
                                              );
                                            } : null,
                                            child: const Text(
                                              'Crear cuenta',
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
                        );
                      },
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
