import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wund/models/user_repository.dart';
import 'package:wund/pages/login_page.dart';
import 'package:wund/widgets/auth_check.dart';

import '../services/auth_services.dart';

class CadastroPage extends StatefulWidget {
  CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  final nome = TextEditingController();

  bool esconderSenha = true;
  bool loading = false;

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
      return const Icon(
        FontAwesomeIcons.solidEye,
        size: 17,
      );
    } else {
      return const Icon(
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

  registrar(nome) async {
    setState(() {
      loading = true;
    });
    try {
      await context.read<AuthService>().registrar(email.text, senha.text);
      await context.read<UserRepository>().saveName(nome);
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
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: Text(
                      'Cadastro',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    child: TextFormField(
                      controller: nome,
                      decoration: const InputDecoration(
                        focusColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o seu nome!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 24),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        focusColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o seu email!';
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
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () => mudarValor(),
                            icon: iconeSenha(esconderSenha),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo),
                          ),
                          border: const OutlineInputBorder(),
                          focusColor: Colors.white,
                          labelText: 'Senha'),
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
                      style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(160, 50)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          registrar(nome.text);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AuthCheck();
                          }));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (loading)
                            ? [
                                const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.indigo,
                                    ),
                                  ),
                                )
                              ]
                            : [
                                const Icon(
                                  Icons.check,
                                  color: Colors.indigo,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    'Cadastrar-se',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.indigo),
                                  ),
                                )
                              ],
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AuthCheck();
                          })),
                      child: Text(
                        'Já tem uma conta? realize o login!',
                        style: const TextStyle(color: Colors.white),
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
