import 'package:connections/models.dart';
import 'package:connections/ui_components/word_button.dart';
import 'package:flutter/material.dart';

class EditConnections extends StatefulWidget {
  const EditConnections(
      {super.key,
      required this.currentConnections,
      required this.updateCurrentConnections,
      required this.setParentState});

  final ConnectionsGroup currentConnections;
  final Function(ConnectionsGroup newGroup) updateCurrentConnections;
  final StateSetter setParentState;

  @override
  State<EditConnections> createState() => _EditConnectionsState();
}

class _EditConnectionsState extends State<EditConnections> {
  late ConnectionsGroup editedConnections;
  @override
  void initState() {
    editedConnections = widget.currentConnections;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // for (var i = 0; i < widget.currentConnections.easyGroup.words.length; i++) {
    //   easyGroup.add(WordButton(word: word, onPressed: onPressed, isSelected: isSelected))
    // }
    List<Widget> easyGroup = [];

    for (var word in widget.currentConnections.easyGroup.words) {
      easyGroup.add(
        WordButton(
          word: word.word,
          onPressed: () async {
            var editedWord = await editWord(word);
            var wordIndex = editedConnections.easyGroup.words.indexOf(word);

            setState(() {
              editedConnections.easyGroup.words[wordIndex] = WordAndColor(
                  word: editedWord.word, correctColor: editedWord.correctColor);
            });
          },
          isSelected: false,
        ),
      );
    }

    List<Widget> mediumGroup = [];

    for (var word in widget.currentConnections.mediumGroup.words) {
      mediumGroup.add(
        WordButton(
          word: word.word,
          onPressed: () async {
            var editedWord = await editWord(word);
            var wordIndex = editedConnections.mediumGroup.words.indexOf(word);

            setState(() {
              editedConnections.mediumGroup.words[wordIndex] = WordAndColor(
                  word: editedWord.word, correctColor: editedWord.correctColor);
            });
          },
          isSelected: false,
        ),
      );
    }

    List<Widget> hardGroup = [];

    for (var word in widget.currentConnections.hardGroup.words) {
      hardGroup.add(
        WordButton(
          word: word.word,
          onPressed: () async {
            var editedWord = await editWord(word);
            var wordIndex = editedConnections.hardGroup.words.indexOf(word);

            setState(() {
              editedConnections.hardGroup.words[wordIndex] = WordAndColor(
                  word: editedWord.word, correctColor: editedWord.correctColor);
            });
          },
          isSelected: false,
        ),
      );
    }

    List<Widget> extraHardGroup = [];

    for (var word in widget.currentConnections.extraHardGroup.words) {
      extraHardGroup.add(
        WordButton(
          word: word.word,
          onPressed: () async {
            var editedWord = await editWord(word);
            var wordIndex =
                editedConnections.extraHardGroup.words.indexOf(word);

            setState(() {
              editedConnections.extraHardGroup.words[wordIndex] = WordAndColor(
                  word: editedWord.word, correctColor: editedWord.correctColor);
            });
          },
          isSelected: false,
        ),
      );
    }

    return Column(
      children: [
        const Text("Edit easy group:"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...easyGroup],
        ),
        const SizedBox(height: 20),
        const Text("Edit medium group:"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...mediumGroup],
        ),
        const SizedBox(height: 20),
        const Text("Edit hard group:"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...hardGroup],
        ),
        const SizedBox(height: 20),
        const Text("Edit extra hard group:"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...extraHardGroup],
        ),
        const SizedBox(height: 20),
        TextButton(
            onPressed: () {
              setState(() {
                widget.updateCurrentConnections(editedConnections);
              });
            },
            child: const Text("Save"))
      ],
    );
  }

  Future<WordAndColor> editWord(WordAndColor currentWord) async {
    TextEditingController controller =
        TextEditingController(text: currentWord.word);
    var newWord = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return SimpleDialog(
          children: [
            const Column(
              children: [Text("edit word:")],
            ),
            TextField(controller: controller),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
          ],
        );
      },
    );

    return WordAndColor(
      word: newWord,
      correctColor: currentWord.correctColor,
    );
  }
}
