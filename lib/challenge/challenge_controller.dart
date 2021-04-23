import 'package:flutter/cupertino.dart';

class ChallengeController {
  final currentPageNotifier = ValueNotifier<int>(1);
  int qtdAwnserRight = 0;

  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;
}
