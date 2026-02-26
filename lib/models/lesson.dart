/// A single lesson (课) — the smallest learning unit.
/// Each lesson has 5 steps: thought experiment → teaching → dialogue → reflection → quiz.
class Lesson {
  final String id;
  final String titleZh;
  final String titleEn;
  final String philosopherId;
  final ThoughtExperiment thoughtExperiment;
  final Teaching teaching;
  final Dialogue dialogue;
  final Reflection reflection;
  final List<QuizQuestion> quiz;

  const Lesson({
    required this.id,
    required this.titleZh,
    required this.titleEn,
    required this.philosopherId,
    required this.thoughtExperiment,
    required this.teaching,
    required this.dialogue,
    required this.reflection,
    required this.quiz,
  });
}

// ─── Step 1: Thought Experiment ───

class ThoughtExperiment {
  final String? stepNameZh; // 自定义步骤名，默认"思想实验"
  final String? stepNameEn; // Custom step name, defaults to "Thought Experiment"
  final String? choicesHeadingZh; // 选项标题，默认"你会怎么做？"
  final String? choicesHeadingEn; // Choices heading, defaults to "What would you do?"
  final String scenarioZh;
  final String scenarioEn;
  final List<ExperimentChoice> choices;
  final String commonTransitionZh;
  final String commonTransitionEn;

  const ThoughtExperiment({
    this.stepNameZh,
    this.stepNameEn,
    this.choicesHeadingZh,
    this.choicesHeadingEn,
    required this.scenarioZh,
    required this.scenarioEn,
    required this.choices,
    required this.commonTransitionZh,
    required this.commonTransitionEn,
  });
}

class ExperimentChoice {
  final String textZh;
  final String textEn;
  final String transitionZh;
  final String transitionEn;

  const ExperimentChoice({
    required this.textZh,
    required this.textEn,
    required this.transitionZh,
    required this.transitionEn,
  });
}

// ─── Step 2: Core Teaching ───

class Teaching {
  final String backgroundZh;
  final String backgroundEn;
  final List<TeachingStep> steps;
  final String coreInsightZh;
  final String coreInsightEn;
  final String modernAnalogyZh;
  final String modernAnalogyEn;
  final AnalogyQuestion? analogyQuestion;
  final String legacyZh;
  final String legacyEn;

  const Teaching({
    this.backgroundZh = '',
    this.backgroundEn = '',
    required this.steps,
    required this.coreInsightZh,
    required this.coreInsightEn,
    required this.modernAnalogyZh,
    required this.modernAnalogyEn,
    this.analogyQuestion,
    required this.legacyZh,
    required this.legacyEn,
  });
}

class TeachingStep {
  final String contentZh;
  final String contentEn;
  final String? extraExplanationZh;
  final String? extraExplanationEn;

  const TeachingStep({
    required this.contentZh,
    required this.contentEn,
    this.extraExplanationZh,
    this.extraExplanationEn,
  });
}

class AnalogyQuestion {
  final String questionZh;
  final String questionEn;
  final List<AnalogyOption> options;

  const AnalogyQuestion({
    required this.questionZh,
    required this.questionEn,
    required this.options,
  });
}

class AnalogyOption {
  final String textZh;
  final String textEn;

  const AnalogyOption({required this.textZh, required this.textEn});
}

// ─── Step 3: Dialogue ───

class Dialogue {
  final String startNodeId;
  final List<DialogueNode> nodes;
  final String methodSummaryZh;
  final String methodSummaryEn;
  final OpponentPreview? opponentPreview;

  const Dialogue({
    required this.startNodeId,
    required this.nodes,
    required this.methodSummaryZh,
    required this.methodSummaryEn,
    this.opponentPreview,
  });
}

class DialogueNode {
  final String id;
  final String speaker; // "philosopher" / "narrator"
  final String textZh;
  final String textEn;
  final List<DialogueChoice>? choices; // null = auto-advance
  final String? nextNodeId; // used when no choices
  final bool isEndNode;

  const DialogueNode({
    required this.id,
    required this.speaker,
    required this.textZh,
    required this.textEn,
    this.choices,
    this.nextNodeId,
    this.isEndNode = false,
  });
}

class DialogueChoice {
  final String textZh;
  final String textEn;
  final String nextNodeId;

  const DialogueChoice({
    required this.textZh,
    required this.textEn,
    required this.nextNodeId,
  });
}

class OpponentPreview {
  final String nameZh;
  final String nameEn;
  final String textZh;
  final String textEn;

  const OpponentPreview({
    required this.nameZh,
    required this.nameEn,
    required this.textZh,
    required this.textEn,
  });
}

// ─── Step 4: Reflection ───

class Reflection {
  final String questionZh;
  final String questionEn;
  final List<ReflectionStance>? stances; // optional pre-choice before writing
  final int xpReward;

  const Reflection({
    required this.questionZh,
    required this.questionEn,
    this.stances,
    this.xpReward = 20,
  });
}

class ReflectionStance {
  final String textZh;
  final String textEn;

  const ReflectionStance({required this.textZh, required this.textEn});
}

// ─── Step 5: Quiz ───

class QuizQuestion {
  final String questionZh;
  final String questionEn;
  final List<QuizOption> options;
  final int correctIndex;
  final String explanationZh;
  final String explanationEn;

  const QuizQuestion({
    required this.questionZh,
    required this.questionEn,
    required this.options,
    required this.correctIndex,
    required this.explanationZh,
    required this.explanationEn,
  });
}

class QuizOption {
  final String textZh;
  final String textEn;

  const QuizOption({required this.textZh, required this.textEn});
}
