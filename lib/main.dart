import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasporedi/pocetna.dart';
import 'firebase_options.dart';
import 'package:animated_login/animated_login.dart';
import 'dialog_builders.dart';
import 'login_functions.dart';

import 'package:async/async.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: Pocetna()));

  runApp(const ProviderScope(child: LoginPage()));
}

class LoginPage extends StatelessWidget {
  /// Main app widget.
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Login',
      theme: ThemeData(
          primarySwatch: Colors.blue), //const MaterialColor(0xFF6666FF, color)
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',

      routes: {
        '/login': (BuildContext context) => LoginScreen(),
        '/forgotPass': (BuildContext context) => const ForgotPasswordScreen(),
      },
    );
  }
}

/// Example login screen
class LoginScreen extends StatefulWidget {
  /// with the help of [LoginTexts] class.
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  /// Current auth mode, default is [AuthMode.login].
  AuthMode currentMode = AuthMode.login;

  CancelableOperation? _operation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Pocetna();
              } else {
                return AnimatedLogin(
                  onLogin: (LoginData data) async => _authOperationLogin(
                      LoginFunctions(context).onLogin(data)),
                  onSignup: (SignUpData data) async => _authOperationSignUp(
                      LoginFunctions(context).onSignup(data)),
                  onForgotPassword: _onForgotPassword,
                  //logo: Image.asset(
                  //   'assets/images/syntaxent.png',
                  //   width: 5000,
                  //  ),
                  // backgroundImage: 'images/background_image.jpg',
                  signUpMode: SignUpModes.both,
                  socialLogins: _socialLogins(context),
                  loginDesktopTheme: _desktopTheme,
                  loginMobileTheme: _mobileTheme,
                  loginTexts: _loginTexts,

                  emailValidator: ValidatorModel(
                      validatorCallback: (String? email) =>
                          'Unesite Email! $email'),
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,

                  initialMode: currentMode,
                  onAuthModeChange: (AuthMode newMode) async {
                    currentMode = newMode;
                    await _operation?.cancel();
                  },
                );
              }
            }));
  }

  Future<String?> _authOperationLogin(Future<String?> func) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(func);
    final String? res = await _operation?.valueOrCancellation();
    if (_operation?.isCompleted == true) {
      prijava();
    }
    return res;
  }

  Future<String?> _authOperationSignUp(Future<String?> func) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(func);
    final String? res = await _operation?.valueOrCancellation();
    if (_operation?.isCompleted == true) {
      signup();
    }
    return res;
  }

  Future signup() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }

  Future prijava() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }

  Future<String?> _onForgotPassword(String email) async {
    await _operation?.cancel();
    return await LoginFunctions(context).onForgotPassword(email);
  }

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *DESKTOP* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
        // To set the color of button text, use foreground color.
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        dialogTheme: const AnimatedDialogTheme(
          languageDialogTheme: LanguageDialogTheme(
              optionMargin: EdgeInsets.symmetric(horizontal: 80)),
        ),
        loadingSocialButtonColor: Colors.blue,
        loadingButtonColor: Colors.white,
      );

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *MOBILE* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _mobileTheme => LoginViewTheme(
        // showLabelTexts: false,
        backgroundColor: Colors.blue, // const Color(0xFF6666FF),
        formFieldBackgroundColor: Colors.white,
        formWidthRatio: 60,
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        animatedComponentOrder: const <AnimatedComponent>[
          AnimatedComponent(
            component: LoginComponents.logo,
            animationType: AnimationType.right,
          ),
          AnimatedComponent(component: LoginComponents.title),
          AnimatedComponent(component: LoginComponents.description),
          AnimatedComponent(component: LoginComponents.formTitle),
          AnimatedComponent(component: LoginComponents.socialLogins),
          AnimatedComponent(component: LoginComponents.useEmail),
          AnimatedComponent(component: LoginComponents.form),
          AnimatedComponent(component: LoginComponents.notHaveAnAccount),
          AnimatedComponent(component: LoginComponents.forgotPassword),
          AnimatedComponent(component: LoginComponents.changeActionButton),
          AnimatedComponent(component: LoginComponents.actionButton),
        ],
      );

  LoginTexts get _loginTexts => LoginTexts(
        nameHint: _username,
        login: _login,
        signUp: _signup,
      );

  /// You can adjust the texts in the screen according to the current language
  /// With the help of [LoginTexts], you can create a multilanguage scren.
  String get _username => 'Ime Škole';

  String get _login => 'Prijava';

  String get _signup => 'Registracija';

  Future googleSignIn() async {}

  /// Social login options, you should provide callback function and icon path.
  /// Icon paths should be the full path in the assets
  /// Don't forget to also add the icon folder to the "pubspec.yaml" file.
  List<SocialLogin> _socialLogins(BuildContext context) => <SocialLogin>[
        SocialLogin(
            callback: () async {
              googleSignIn();
            },
            iconPath: 'assets/images/google.png'),
      ];

  Future<String?> _socialCallback(String type) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(
        LoginFunctions(context).socialLogin(type));
    final String? res = await _operation?.valueOrCancellation();
    if (_operation?.isCompleted == true && res == null) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    }
    return res;
  }
}

/// Example forgot password screen
class ForgotPasswordScreen extends StatelessWidget {
  /// Example forgot password screen that user is navigated to
  /// after clicked on "Forgot Password?" text.
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Zaboravili lozinku?'),
      ),
    );
  }
}
