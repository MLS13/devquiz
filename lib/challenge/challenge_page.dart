import 'package:devquiz/challenge/challenge_controller.dart';
import 'package:devquiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:devquiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:devquiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:devquiz/result/result_page.dart';
import 'package:devquiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  const ChallengePage({
    Key key,
    @required this.questions,
    @required this.title,
  }) : super(key: key);
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      controller.currentPage = pageController.page.toInt() + 1;
    });
  }

  void nextPage() {
    if (controller.currentPage < widget.questions.length)
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
  }

  void onSelected(bool value) {
    if (value) controller.qtdAwnserRight++;
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  lenght: widget.questions.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: widget.questions
            .map((e) => QuizWidget(
                  question: e,
                  onSelected: onSelected,
                ))
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotifier,
            builder: (context, value, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (!(value == widget.questions.length))
                  Expanded(
                    child: NextButtonWidget.white(
                      label: "Pular",
                      ontTap: nextPage,
                    ),
                  ),
                if (value == widget.questions.length)
                  Expanded(
                    child: NextButtonWidget.green(
                      label: "Confirmar",
                      ontTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => ResultPage(
                              title: widget.title,
                              lenght: widget.questions.length,
                              result: controller.qtdAwnserRight,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
