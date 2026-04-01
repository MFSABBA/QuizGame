import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const QuizApp());
}


class QuizApp extends StatelessWidget {
  const QuizApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[900],
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/quiz': (context) => const QuizPage(),
        '/result': (context) => const ResultPage(),
      },
    );
  }
}


/* ================= HOME ================= */


class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Game')),
      body: Center(
        child: ElevatedButton(
          child: const Text(
            'Inizia Quiz',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/quiz');
          },
        ),
      ),
    );
  }
}


/* ================= QUIZ ================= */


class QuizPage extends StatefulWidget {
  const QuizPage({super.key});


  @override
  State<QuizPage> createState() => _QuizPageState();
}


class _QuizPageState extends State<QuizPage> {
  List domande = [];
  int indice = 0;
  int punteggio = 0;
  bool caricato = false;


  @override
  void initState() {
    super.initState();
    caricaDomande();
  }


  Future<void> caricaDomande() async {
    final url =
    Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple');
    final risposta = await http.get(url);
    final dati = jsonDecode(risposta.body);


    setState(() {
      domande = dati['results'];
      caricato = true;
    });
  }


  void rispondi(String rispostaUtente) {
    String rispostaCorretta = domande[indice]['correct_answer'];


    if (rispostaUtente == rispostaCorretta) {
      punteggio++;
    }


    if (indice < domande.length - 1) {
      setState(() {
        indice++;
      });
    } else {
      Navigator.pushReplacementNamed(
        context,
        '/result',
        arguments: punteggio,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    if (!caricato) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }


    List risposte = List.from(domande[indice]['incorrect_answers']);
    risposte.add(domande[indice]['correct_answer']);
    risposte.shuffle();


    return Scaffold(
      appBar: AppBar(
        title: Text('Domanda ${indice + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              domande[indice]['question'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ...risposte.map((r) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () => rispondi(r),
                  child: Text(
                    r,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}


/* ================= RISULTATO ================= */


class ResultPage extends StatelessWidget {
  const ResultPage({super.key});


  @override
  Widget build(BuildContext context) {
    final int punteggio =
    ModalRoute.of(context)!.settings.arguments as int;


    return Scaffold(
      appBar: AppBar(title: const Text('Risultato')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Punteggio finale',
              style: TextStyle(fontSize: 22, color: Colors.grey[400]),
            ),
            const SizedBox(height: 10),
            Text(
              '$punteggio / 10',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Rigioca'),
            ),
          ],
        ),
      ),
    );
  }
}
