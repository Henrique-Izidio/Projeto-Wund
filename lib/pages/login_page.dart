import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../services/auth_services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool esconderSenha = true;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  mudarValor() {
    if (!esconderSenha) {
      setState(() {
        esconderSenha = true;
      });
    } else {
      setState(() {
        esconderSenha = false;
      });
    }
  }

  iconeSenha(esconderSenha) {
    if (!esconderSenha) {
      return Icon(
        FontAwesomeIcons.solidEye,
        size: 17,
      );
    } else {
      return Icon(
        FontAwesomeIcons.solidEyeSlash,
        size: 17,
      );
    }
  }

  textSenha(esconderSenha) {
    if (esconderSenha) {
      return true;
    } else {
      return false;
    }
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = 'Bem Vindo!';
        actionButton = 'Login';
        toggleButton = 'Ainda não tem uma conta? Cadastra-se';
      } else {
        titulo = 'Cadastro';
        actionButton = 'Cadastrar';
        toggleButton = 'Já tem um login?';
      }
    });
  }

  login() async {
    setState(() {
      loading = true;
    });
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (err) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.message)));
    }
  }

  registrar() async {
    setState(() {
      loading = true;
    });
    try {
      await context.read<AuthService>().registrar(email.text, senha.text);
    } on AuthException catch (err) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(19, 233, 222, 80),
                  Color.fromRGBO(5, 92, 215, 80),
                ]),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        focusColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe seu email!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    child: TextFormField(
                      autofocus: true,
                      obscureText: textSenha(esconderSenha),
                      controller: senha,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () => mudarValor(),
                            icon: iconeSenha(esconderSenha),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo),
                          ),
                          border: const OutlineInputBorder(),
                          focusColor: Colors.white,
                          labelText: 'senha'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe sua senha!';
                        } else if (value.length < 6) {
                          return 'Informe uma senha com mais que 6 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (isLogin) {
                            login();
                          } else {
                            registrar();
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (loading)
                            ? [
                                const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ]
                            : [
                                const Icon(Icons.check),
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    actionButton,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () => setFormAction(!isLogin),
                      child: Text(
                        toggleButton,
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
