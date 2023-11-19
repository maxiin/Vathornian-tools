import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            title: 'Vathornian Tools',
            theme: ThemeData(primarySwatch: Colors.deepPurple),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: const MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Map<String, String> common = {
  'a': 'fa',
  'b': 'pra',
  'c': 'na',
  'd': 'kra',
  'e': 'ba',
  'f': 'ja',
  'g': 'mna',
  'h': 'vra',
  'i': 'va',
  'j': 'za',
  'k': 'xa',
  'l': 'ga',
  'm': 'da',
  'n': 'na',
  'o': 'ha',
  'p': 'pta',
  'q': 'dra',
  'r': 'ra',
  's': 'ma',
  't': 'tra',
  'u': 'ca',
  'v': 'vna',
  'w': 'wa',
  'x': 'xva',
  'y': 'bxa',
  'z': 'hva',
};
Map<String, String> commonUpper = {
  'A': 'Fa',
  'B': 'Pra',
  'C': 'Na',
  'D': 'Kra',
  'E': 'Ba',
  'F': 'Ja',
  'G': 'Mna',
  'H': 'Vra',
  'I': 'Va',
  'J': 'Za',
  'K': 'Xa',
  'L': 'Ga',
  'M': 'Da',
  'N': 'Na',
  'O': 'Ha',
  'P': 'Pta',
  'Q': 'Dra',
  'R': 'Ra',
  'S': 'Ma',
  'T': 'Tra',
  'U': 'Ca',
  'V': 'Vna',
  'W': 'Wa',
  'X': 'Xva',
  'Y': 'Bxa',
  'Z': 'Hva',
};

Map<String, String> vath = {
  'pra': 'b',
  'kra': 'd',
  'mna': 'g',
  'vra': 'h',
  'pta': 'p',
  'dra': 'q',
  'tra': 't',
  'vna': 'v',
  'xva': 'x',
  'bxa': 'y',
  'hva': 'z',
  'fa': 'a',
  'na': '(c/n)',
  'ba': 'e',
  'ja': 'f',
  'va': 'i',
  'za': 'j',
  'xa': 'k',
  'ga': 'l',
  'da': 'm',
  'ha': 'o',
  'ra': 'r',
  'ma': 's',
  'ca': 'u',
  'wa': 'w',
};
Map<String, String> vathUpper = {
  'Fa': 'A',
  'Pra': 'B',
  'Na': '(C/N)',
  'Kra': 'D',
  'Ba': 'E',
  'Ja': 'F',
  'Mna': 'G',
  'Vra': 'H',
  'Va': 'I',
  'Za': 'J',
  'Xa': 'K',
  'Ga': 'L',
  'Da': 'M',
  'Ha': 'O',
  'Pta': 'P',
  'Dra': 'Q',
  'Ra': 'R',
  'Ma': 'S',
  'Tra': 'T',
  'Ca': 'U',
  'Vna': 'V',
  'Wa': 'W',
  'Xva': 'X',
  'Bxa': 'Y',
  'Hva': 'Z',
};

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _commonController =
      TextEditingController(text: '');
  final TextEditingController _vathornianController =
      TextEditingController(text: '');

  _commonChange(String val) {
    var text =
        val.split('').map((e) => common[e] ?? commonUpper[e] ?? e).join();
    setState(() {
      _vathornianController.text = text;
    });
  }

  _vathornianChange(String val) {
    var vathDict = vath.keys.map((e) => '$e|').join();
    var vathDictUpper = vathUpper.keys.map((e) => '$e|').join();
    vathDictUpper = vathDictUpper.substring(0, vathDictUpper.length - 1);
    var list = RegExp('$vathDict$vathDictUpper|\n|.')
        .allMatches(val)
        .map((e) => e.group(0))
        .toList();
    list = list.map((e) {
      if (e != null) {
        if (e.length > 1) {
          return vath[e] ?? vathUpper[e] ?? e;
        }
        return e;
      }
    }).toList();
    setState(() {
      _commonController.text = list.join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: IconButton(
            onPressed: () {
              MyApp.themeNotifier.value =
                  MyApp.themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
              setState(() {});
            },
            icon: MyApp.themeNotifier.value == ThemeMode.light
                ? const Icon(Icons.nightlight)
                : const Icon(Icons.sunny)),
        body: Center(
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _commonController,
                      onChanged: _commonChange,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintText: "Text in Common",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _vathornianController,
                      onChanged: _vathornianChange,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintText: "Text in Vathornian"),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
