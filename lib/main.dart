import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dicoding Notes",
      theme: ThemeData(),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 228, 250, 251),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: LoginForm(onLoginPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotesScreen(),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final VoidCallback onLoginPressed;

  const LoginForm({super.key, required this.onLoginPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              children: [
                Text(
                  "Username",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const TextField(
              decoration: InputDecoration(labelText: "Enter your username"),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Text(
                  "Password",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const TextField(
              decoration: InputDecoration(labelText: "Enter your password"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: onLoginPressed, child: const Text("Login"))
          ],
        );
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String note;
  final VoidCallback onBackPressed;

  const DetailScreen(
      {super.key, required this.note, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(note),
      ),
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> notes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: <Widget>[
              Expanded(
                child: GridView.count(
                  crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                  padding: const EdgeInsets.all(20),
                  children: List.generate(
                    notes.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                note: notes[index],
                                onBackPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(notes[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: constraints.maxWidth,
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Write Here",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {},
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  notes.add(value);
                                });
                              }
                            },
                            decoration:
                                const InputDecoration(hintText: "Add a note"),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
