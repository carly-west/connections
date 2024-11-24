import 'package:connections/edit_connections.dart';
import 'package:connections/models.dart';
import 'package:connections/ui_components/word_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<WordAndColor> selectedWords = [];
  List<WordAndColor> wordList = [];
  List<WordAndColor> correctWords = [];
  late ConnectionsGroup sampleGroup;

  @override
  void initState() {
    sampleGroup = ConnectionsGroup(
      easyGroup: WordsAndCategory(
        category: "Pets",
        words: [
          WordAndColor(word: "cat", correctColor: Colors.green),
          WordAndColor(word: "dog", correctColor: Colors.green),
          WordAndColor(word: "rabbit", correctColor: Colors.green),
          WordAndColor(word: "gold fish", correctColor: Colors.green),
        ],
      ),
      mediumGroup: WordsAndCategory(
        category: "Fruits",
        words: [
          WordAndColor(word: "apple", correctColor: Colors.orange),
          WordAndColor(word: "grape", correctColor: Colors.orange),
          WordAndColor(word: "watermelon", correctColor: Colors.orange),
          WordAndColor(word: "lemon", correctColor: Colors.orange),
        ],
      ),
      hardGroup: WordsAndCategory(
        category: "Colors",
        words: [
          WordAndColor(word: "salmon", correctColor: Colors.yellow),
          WordAndColor(word: "orange", correctColor: Colors.yellow),
          WordAndColor(word: "blue", correctColor: Colors.yellow),
          WordAndColor(word: "lilac", correctColor: Colors.yellow),
        ],
      ),
      extraHardGroup: WordsAndCategory(
        category: "Words starting with months of the year",
        words: [
          WordAndColor(word: "juniper", correctColor: Colors.purple),
          WordAndColor(word: "octagon", correctColor: Colors.purple),
          WordAndColor(word: "decimal", correctColor: Colors.purple),
          WordAndColor(word: "marathon", correctColor: Colors.purple),
        ],
      ),
    );

    initializeWords();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var group in sampleGroup.easyGroup.words) {
      debugPrint(group.word);
    }
    List<Widget> wordButtons = [];

    bool canSelectMore = selectedWords.length < 4;

    for (var word in wordList) {
      debugPrint("word ${word.word}");
      wordButtons.add(
        WordButton(
          key: UniqueKey(),
          isSelected: selectedWords.contains(word),
          onPressed: () {
            if (!selectedWords.contains(word) && canSelectMore) {
              setState(() {
                selectedWords.add(word);
              });
            } else if (selectedWords.contains(word)) {
              setState(() {
                selectedWords.remove(word);
              });
            }
          },
          word: word.word.toUpperCase(),
          correctButtonColor:
              correctWords.contains(word) ? word.correctColor : null,
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => showEditDialog(setState),
                  child: const Text("Edit connections")),
              const SizedBox(height: 50),
              SizedBox(
                width: 600,
                height: 600,
                child: GridView.count(
                  mainAxisSpacing: 50,
                  crossAxisSpacing: 50,
                  crossAxisCount: 4,
                  children: [...wordButtons],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                child: const Text("SUBMIT"),
                onPressed: () {
                  if (checkIsCorrect()) {
                    setState(() {
                      correctWords.addAll(selectedWords);
                      selectedWords = [];
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkIsCorrect() {
    if (selectedWords.length < 4) {
      return false;
    }
    List<Difficulty> wordTypes = [];
    for (var word in selectedWords) {
      if (sampleGroup.easyGroup.words.contains(word)) {
        wordTypes.add(Difficulty.easy);
      } else if (sampleGroup.mediumGroup.words.contains(word)) {
        wordTypes.add(Difficulty.medium);
      } else if (sampleGroup.hardGroup.words.contains(word)) {
        wordTypes.add(Difficulty.hard);
      } else if (sampleGroup.extraHardGroup.words.contains(word)) {
        wordTypes.add(Difficulty.extraHard);
      }
    }

    return wordTypes.toSet().length == 1;
  }

  void showEditDialog(StateSetter parentState) {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          children: [
            EditConnections(
              currentConnections: sampleGroup,
              setParentState: parentState,
              updateCurrentConnections: (newGroup) {
                // for (var group in newGroup.easyGroup.words) {
                //   debugPrint(group.word);
                // }
                parentState(() {
                  sampleGroup = newGroup;
                  initializeWords();

                  debugPrint("carly new group");
                  Navigator.of(context).pop();
                });
              },
            )
          ],
        );
      },
    );
  }

  void initializeWords() {
    wordList = [];
    wordList.addAll(sampleGroup.easyGroup.words);
    wordList.addAll(sampleGroup.mediumGroup.words);
    wordList.addAll(sampleGroup.hardGroup.words);
    wordList.addAll(sampleGroup.extraHardGroup.words);

    wordList.shuffle();
  }
}
