import 'dart:ui';

class ConnectionsGroup {
  ConnectionsGroup({
    required this.easyGroup,
    required this.mediumGroup,
    required this.hardGroup,
    required this.extraHardGroup,
  });
  final WordsAndCategory easyGroup;
  final WordsAndCategory mediumGroup;
  final WordsAndCategory hardGroup;
  final WordsAndCategory extraHardGroup;
}

class WordsAndCategory {
  WordsAndCategory({
    required this.words,
    required this.category,
  });
  final List<WordAndColor> words;
  final String category;
}

class WordAndColor {
  WordAndColor({
    required this.word,
    required this.correctColor,
  });
  final String word;
  final Color correctColor;
}

enum Difficulty {
  easy,
  medium,
  hard,
  extraHard,
}
