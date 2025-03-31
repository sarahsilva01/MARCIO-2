import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = const AssetImage("images/padrao.png");
  var _resultadoFinal = "Boa sorte!!!";
  Color _corResultado = Colors.blue;
  int _pontosUsuario = 0;
  int _pontosApp = 0;

  void _resetJogo() {
    setState(() {
      _imagemApp = const AssetImage("images/padrao.png");
      _resultadoFinal = "Boa sorte!!!";
      _corResultado = Colors.blue;
      _pontosUsuario = 0;
      _pontosApp = 0;
    });
  }

  void _opcaoSelecionada(String escolhaUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];

    switch (escolhaApp) {
      case "pedra":
        _imagemApp = const AssetImage("images/pedra.png");
        break;
      case "papel":
        _imagemApp = const AssetImage("images/papel.png");
        break;
      case "tesoura":
        _imagemApp = const AssetImage("images/tesoura.png");
        break;
    }

    // Lógica do resultado
    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      _resultadoFinal = "Parabéns!!! Você ganhou :)";
      _corResultado = Colors.green;
      _pontosUsuario++;
    } else if ((escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")) {
      _resultadoFinal = "Puxa!!! Você perdeu :(";
      _corResultado = Colors.red;
      _pontosApp++;
    } else {
      _resultadoFinal = "Empate!!! Tente novamente :/";
      _corResultado = Colors.blue;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JokenPo"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetJogo,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Image(image: _imagemApp),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha uma opção abaixo:",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _opcaoSelecionada("pedra"),
                    child: const Image(
                      image: AssetImage("images/pedra.png"),
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text("Pedra"),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _opcaoSelecionada("papel"),
                    child: const Image(
                      image: AssetImage("images/papel.png"),
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text("Papel"),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _opcaoSelecionada("tesoura"),
                    child: const Image(
                      image: AssetImage("images/tesoura.png"),
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text("Tesoura"),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 8),
            child: Text(
              _resultadoFinal,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _corResultado,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text("Você: $_pontosUsuario  |  App: $_pontosApp"),
        ],
      ),
    );
  }
}
