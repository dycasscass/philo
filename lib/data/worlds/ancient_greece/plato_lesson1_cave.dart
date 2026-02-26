import '../../../models/lesson.dart';

const platoLesson1Cave = Lesson(
  id: 'plato_cave',
  titleZh: '洞穴寓言 — 你看到的是真实的吗？',
  titleEn: 'The Allegory of the Cave — Is What You See Real?',
  philosopherId: 'plato',

  // ─── Step 1: Thought Experiment ───
  thoughtExperiment: ThoughtExperiment(
    scenarioZh:
        '想象这样一个场景：假设你从出生起就只通过一块屏幕了解世界，你看到的一切都合理、自洽、没有破绽。\n\n有一天有人告诉你：屏幕外面还有一个完全不同的世界。',
    scenarioEn:
        'Imagine this: Suppose that since birth, you\'ve only known the world through a screen. Everything you see is consistent, logical, and flawless.\n\nOne day, someone tells you: there\'s an entirely different world beyond the screen.',
    choices: [
      ExperimentChoice(
        textZh: '我想打开门看看。\n就算外面可能不好，我也想自己确认。',
        textEn:
            'I want to open the door and see.\nEven if it\'s not great out there, I want to find out for myself.',
        transitionZh: '你有一种直觉——想亲眼看看真相。\n两千多年前，有一个人把你的这种直觉变成了哲学史上最著名的寓言。',
        transitionEn:
            'You have an instinct — to see the truth with your own eyes. \nOver two thousand years ago, someone turned that very instinct into the most famous allegory in philosophy.',
      ),
      ExperimentChoice(
        textZh: '我为什么要相信他？\n屏幕上的世界我已经很熟悉了，那就是我的现实。',
        textEn:
            'Why should I believe them?\nI\'m already familiar with the world on screen — that IS my reality.',
        transitionZh: '你选择了信任已有的经验。但柏拉图会问你：如果你的全部经验本身就是被设计的呢？',
        transitionEn:
            'You chose to trust your existing experience. But Plato would ask: what if your entire experience was designed?',
      ),
      ExperimentChoice(
        textZh: '就算外面有"真实世界"，那跟我有什么关系？\n我在这里活得好好的。',
        textEn:
            'Even if there\'s a "real world" out there, what does that have to do with me?\nI\'m doing just fine here.',
        transitionZh: '你觉得"真不真实"不重要，过得好才重要。柏拉图听到这话，大概会叹一口气——然后给你讲一个故事。',
        transitionEn:
            'You think "real or not" doesn\'t matter — what matters is living well. Plato would probably sigh at this — and then tell you a story.',
      ),
    ],
    commonTransitionZh:
        '两千多年前，柏拉图讲了一个几乎一样的故事——有些人从出生起就被锁在一个洞穴里，把墙上的影子当成了全部的现实。他管这个叫"洞穴寓言"。',
    commonTransitionEn:
        'Over two thousand years ago, Plato told an almost identical story — some people were chained in a cave from birth, mistaking shadows on the wall for all of reality. He called it "The Allegory of the Cave."',
  ),

  // ─── Step 2: Core Teaching ───
  teaching: Teaching(
    backgroundZh:
        '柏拉图出生在雅典的贵族家庭，年轻时跟随苏格拉底学习。苏格拉底因为"腐蚀青年思想"被民主投票判处死刑，这件事深深震动了柏拉图。他开始追问：为什么大多数人宁愿相信表面的东西，也不愿追寻真相？',
    backgroundEn:
        'Plato was born into an aristocratic Athenian family and studied under Socrates in his youth. When Socrates was sentenced to death by democratic vote for "corrupting the youth," it profoundly shook Plato. He began to ask: why do most people prefer to believe what\'s on the surface rather than seek the truth?',
    steps: [
      // Step 1: The Cave Setup
      TeachingStep(
        contentZh:
            '柏拉图说：想象一个地下洞穴。一群人从出生起就被锁在里面，他们的头被固定住，只能看着前面的墙壁。在他们身后有一堆火，火和他们之间有一条走道，走道上有人举着各种东西走过——动物、器具、人形。火光把这些东西的影子投在墙上。\n\n对这群囚徒来说，墙上的影子就是他们唯一的现实。',
        contentEn:
            'Plato says: imagine an underground cave. A group of people have been chained inside since birth, their heads fixed so they can only face the wall ahead. Behind them burns a fire, and between the fire and the prisoners runs a walkway where others carry various objects — animals, tools, human figures. The firelight casts shadows of these objects onto the wall.\n\nFor these prisoners, the shadows on the wall are their only reality.',
        extraExplanationZh:
            '想象你从小被固定在电影院座位上，只能看银幕，从来没回过头，也不知道身后有放映机。银幕上的画面就是你认识的全部世界。',
        extraExplanationEn:
            'Imagine being strapped to a cinema seat since birth, only able to watch the screen, never turning around, never knowing there\'s a projector behind you. The images on screen are your entire known world.',
      ),
      // Step 2: They believe shadows are real
      TeachingStep(
        contentZh:
            '囚徒们甚至给影子起名字，讨论哪个影子会先出现、以什么顺序出现。谁猜得最准，谁就被认为最聪明。在他们的世界里，"聪明"就是最擅长预测影子的人。',
        contentEn:
            'The prisoners even name the shadows, discussing which shadow appears first and in what order. Whoever guesses most accurately is considered the wisest. In their world, "intelligence" means being best at predicting shadows.',
        extraExplanationZh:
            '就像如果你从小只通过短视频了解某个国家，你会以为那些片段就是那个国家的全貌。你不是被骗了，你只是从来没有机会看到完整的现实。',
        extraExplanationEn:
            'It\'s like if you only knew a country through short videos since childhood — you\'d think those clips were the full picture. You weren\'t deceived; you simply never had the chance to see the complete reality.',
      ),
      // Step 3: A prisoner is freed
      TeachingStep(
        contentZh:
            '有一天，一个囚徒被松开了锁链。他转过头，看到了火。火光刺得他睁不开眼。他又被拉向洞口——阳光更加刺眼，他几乎什么都看不见，痛苦不堪。\n\n真相的第一个特征：它让人不舒服。',
        contentEn:
            'One day, a prisoner is unchained. He turns around and sees the fire. The light burns his eyes. He\'s then dragged toward the cave entrance — the sunlight is even more blinding, and he can barely see anything. It\'s painful.\n\nThe first characteristic of truth: it\'s uncomfortable.',
        extraExplanationZh:
            '为什么真相让人不舒服？因为接受真相意味着否定你之前全部的认知。你以为的"世界"突然变成了"影子"。这种冲击不仅是理智上的，更是情感上的——就像有人告诉你，你记忆中的童年其实不是那样的。',
        extraExplanationEn:
            'Why is truth uncomfortable? Because accepting it means negating everything you previously knew. What you thought was "the world" suddenly becomes "just shadows." This shock isn\'t just intellectual — it\'s emotional. Like someone telling you your childhood memories aren\'t what you thought.',
      ),
      // Step 4: He sees the sun
      TeachingStep(
        contentZh:
            '慢慢地，他的眼睛适应了。他先看到水中的倒影，然后是事物本身，然后是星空，最后——他直视了太阳。\n\n柏拉图说，太阳就是"善的理念"（the Form of the Good）——所有真理和存在的终极源头。看到太阳的那个瞬间，他理解了一切：影子、火光、洞穴——它们在整个秩序中各自的位置。',
        contentEn:
            'Gradually, his eyes adjust. First he sees reflections in water, then things themselves, then the stars, and finally — he looks directly at the sun.\n\nPlato says the sun represents the Form of the Good — the ultimate source of all truth and existence. In that moment of seeing the sun, he understands everything: the shadows, the firelight, the cave — each in its proper place within the grand order.',
        extraExplanationZh:
            '柏拉图不是在说真的太阳。他用太阳来比喻一种终极的真理——当你理解了它，其他所有事情突然都有了意义。就像学数学时突然"开窍"的那个瞬间：一个根本性的原理让所有细节各归其位。',
        extraExplanationEn:
            'Plato isn\'t talking about the literal sun. He uses it as a metaphor for ultimate truth — once you grasp it, everything else suddenly makes sense. Like that "aha" moment in math: one fundamental principle puts all the details in their proper place.',
      ),
      // Step 5: Return to the cave
      TeachingStep(
        contentZh:
            '然后，他回到了洞穴。他试图告诉其他人：你们看到的只是影子，外面有一个真实得多的世界。\n\n其他囚徒的反应？他们觉得他疯了。他的眼睛在黑暗中看不清影子了——他们嘲笑他："你出去一趟，反而变蠢了。"如果有人试图带他们出去，他们甚至会杀了那个人。',
        contentEn:
            'Then he returns to the cave. He tries to tell the others: what you see are merely shadows — there\'s a far more real world outside.\n\nThe other prisoners\' reaction? They think he\'s gone mad. His eyes can no longer make out the shadows in the dark — they mock him: "You went out and came back stupider." If anyone tried to lead them out, they would even kill that person.',
        extraExplanationZh:
            '柏拉图写这段话时，心中想的是他的老师苏格拉底。苏格拉底就是那个"回到洞穴"的人——他试图唤醒雅典人去思考，结果被投票处死了。',
        extraExplanationEn:
            'When Plato wrote this, he was thinking of his teacher Socrates. Socrates was the one who "returned to the cave" — he tried to awaken Athenians to think, and was voted to death for it.',
      ),
    ],
    coreInsightZh:
        '大多数人一辈子都在看影子，以为那就是全部真实。走出洞穴不是一件快乐的事——它痛苦、孤独，甚至危险。但柏拉图认为，那是人唯一值得过的人生。',
    coreInsightEn:
        'Most people spend their entire lives watching shadows, believing them to be all of reality. Leaving the cave isn\'t a joyful experience — it\'s painful, lonely, even dangerous. But Plato believed it\'s the only life worth living.',
    modernAnalogyZh:
        '想想你手机上的信息流。算法根据你过去的行为，推送你"可能喜欢"的内容。你看到的世界越来越像你已经相信的那个样子。这不就是一个数字版的洞穴吗？你看到的"信息"就是墙上的影子，算法就是身后的火光和操偶人。',
    modernAnalogyEn:
        'Think about the feed on your phone. Algorithms push content you "might like" based on your past behavior. The world you see increasingly resembles what you already believe. Isn\'t this a digital cave? The "information" you see are shadows on the wall, and the algorithm is the fire and puppet-masters behind you.',
    analogyQuestion: AnalogyQuestion(
      questionZh: '你觉得"信息茧房"和柏拉图的洞穴是同一回事吗？',
      questionEn:
          'Do you think the "information bubble" and Plato\'s cave are the same thing?',
      options: [
        AnalogyOption(
          textZh: '差不多，都是被限制在部分真相里',
          textEn: 'Pretty much — both limit you to partial truth',
        ),
        AnalogyOption(
          textZh: '不太一样，信息茧房我可以主动打破，但洞穴里的人根本不知道自己被困住了',
          textEn:
              'Not quite — I can actively break out of an information bubble, but cave prisoners don\'t even know they\'re trapped',
        ),
      ],
    ),
    legacyZh:
        '洞穴寓言是西方哲学史上最有影响力的隐喻之一。它影响了后来几乎所有关于"表象与真实"的讨论——从笛卡尔的怀疑论，到《黑客帝国》的蓝色药丸和红色药丸。柏拉图用这个故事想告诉你：哲学不是象牙塔里的游戏，它关乎你如何看待自己的整个人生。',
    legacyEn:
        'The Allegory of the Cave is one of the most influential metaphors in Western philosophy. It shaped nearly every subsequent discussion about appearance vs. reality — from Descartes\' skepticism to The Matrix\'s blue pill and red pill. Plato used this story to tell you: philosophy isn\'t an ivory tower game — it\'s about how you see your entire life.',
  ),

  // ─── Step 3: Dialogue ───
  dialogue: Dialogue(
    startNodeId: 'node_1',
    nodes: [
      DialogueNode(
        id: 'node_1',
        speaker: 'philosopher',
        textZh:
            '来，我再给你讲一个版本。假如你就是那个走出洞穴的人。你看到了阳光，看到了真实的世界。现在你站在洞口，往回看。里面黑洞洞的，你能听到你的朋友们还在讨论影子。你会怎么做？',
        textEn:
            'Come, let me tell you another version. Suppose you are the one who left the cave. You\'ve seen the sunlight, seen the real world. Now you stand at the cave entrance, looking back. It\'s dark inside, and you can hear your friends still debating shadows. What would you do?',
        choices: [
          DialogueChoice(
            textZh: '我会回去，把我看到的告诉他们。',
            textEn: 'I\'d go back and tell them what I saw.',
            nextNodeId: 'node_2a',
          ),
          DialogueChoice(
            textZh: '我不回去了。他们不会信我，回去也没用。',
            textEn:
                'I wouldn\'t go back. They won\'t believe me — it\'s pointless.',
            nextNodeId: 'node_2b',
          ),
          DialogueChoice(
            textZh: '我会回去，但不是用"告诉"的方式——我要想办法让他们自己走出来。',
            textEn:
                'I\'d go back, but not by "telling" them — I\'d find a way to help them walk out themselves.',
            nextNodeId: 'node_2c',
          ),
        ],
      ),
      DialogueNode(
        id: 'node_2a',
        speaker: 'philosopher',
        textZh:
            '好。你回去了。你跟他们说："你们看到的是影子，不是真的。外面有太阳、有树、有真实的颜色。"他们盯着你看了一会儿，然后笑了："你出去一趟，连影子都看不清了。"没有人相信你。你怎么办？',
        textEn:
            'Good. You went back. You told them: "What you see are shadows, not real. Outside there\'s sun, trees, real colors." They stared at you for a moment, then laughed: "You went out and can\'t even see the shadows anymore." Nobody believes you. What now?',
        choices: [
          DialogueChoice(
            textZh: '继续说，总有人会听的。',
            textEn: 'Keep talking — someone will listen eventually.',
            nextNodeId: 'node_3',
          ),
          DialogueChoice(
            textZh: '也许我该换个方式，不直接告诉他们"真相"，而是先让他们对影子产生怀疑。',
            textEn:
                'Maybe I should change my approach — instead of telling them "the truth," first make them doubt the shadows.',
            nextNodeId: 'node_3',
          ),
        ],
      ),
      DialogueNode(
        id: 'node_2b',
        speaker: 'philosopher',
        textZh:
            '你选择留在阳光下。我理解。外面的世界美极了。但是——你能安心吗？你知道你的朋友们还在黑暗里，把影子当成全部的人生。你转过头不看，就等于那一切不存在了吗？',
        textEn:
            'You chose to stay in the sunlight. I understand. The outside world is beautiful. But — can you be at peace? You know your friends are still in the dark, taking shadows for the whole of life. If you turn away, does that make it all disappear?',
        choices: [
          DialogueChoice(
            textZh: '我可以自己过好自己的生活。每个人都有权选择自己的世界。',
            textEn:
                'I can live my own life well. Everyone has the right to choose their own world.',
            nextNodeId: 'node_3',
          ),
          DialogueChoice(
            textZh: '说实话，不太安心。但我害怕回去——害怕他们不理解我，害怕再次陷入黑暗。',
            textEn:
                'Honestly, not really. But I\'m afraid to go back — afraid they won\'t understand me, afraid of falling back into darkness.',
            nextNodeId: 'node_3',
          ),
        ],
      ),
      DialogueNode(
        id: 'node_2c',
        speaker: 'philosopher',
        textZh:
            '有意思。你不想"告诉"他们真相，而是想引导他们。但想想——他们连锁链都没意识到。你打算怎么让一个不知道自己被锁住的人，意识到自己被锁住了？',
        textEn:
            'Interesting. You don\'t want to "tell" them the truth — you want to guide them. But think: they don\'t even realize they\'re chained. How do you make someone who doesn\'t know they\'re bound realize they\'re bound?',
        choices: [
          DialogueChoice(
            textZh: '也许可以先让他们注意到影子有时候不一致——让他们自己产生怀疑。',
            textEn:
                'Maybe I can first help them notice that shadows sometimes don\'t match up — let them develop their own doubts.',
            nextNodeId: 'node_3',
          ),
          DialogueChoice(
            textZh: '也许该直接帮他们解开锁链，就算他们一开始会抗拒。',
            textEn:
                'Maybe I should just unchain them directly, even if they resist at first.',
            nextNodeId: 'node_3',
          ),
        ],
      ),
      // Convergence point
      DialogueNode(
        id: 'node_3',
        speaker: 'philosopher',
        textZh:
            '你知道我的老师苏格拉底是怎么做的吗？他选择了回去。他走进雅典的街头，找人对话，一个问题接一个问题地追问，直到对方发现自己其实什么都不知道。结果呢？他们投票杀了他。\n\n所以我问你一个更难的问题：如果你知道"回去"意味着你可能会死，你还回去吗？',
        textEn:
            'Do you know what my teacher Socrates did? He chose to go back. He walked into the streets of Athens, engaged people in dialogue, question after question, until they realized they knew nothing at all. The result? They voted to kill him.\n\nSo let me ask you a harder question: if you knew that "going back" might mean your death, would you still go?',
        choices: [
          DialogueChoice(
            textZh: '如果我认为真相比我的命更重要——是的。',
            textEn:
                'If I believe truth is more important than my life — yes.',
            nextNodeId: 'node_4a',
          ),
          DialogueChoice(
            textZh: '不值得。死了就什么都没了，活着才能帮更多人。',
            textEn:
                'Not worth it. Dead means nothing — alive, I can help more people.',
            nextNodeId: 'node_4b',
          ),
        ],
      ),
      DialogueNode(
        id: 'node_4a',
        speaker: 'philosopher',
        textZh:
            '苏格拉底也这样想。他说："未经审视的人生不值得过。"对他来说，停止追问就等于死了——比肉体的死亡更可怕。\n\n但我有时候会想……他的妻子和孩子怎么办？是不是存在一种方式，既忠于真理，又不必成为殉道者？',
        textEn:
            'Socrates thought the same. He said: "The unexamined life is not worth living." For him, to stop questioning was already death — worse than physical death.\n\nBut sometimes I wonder... what about his wife and children? Is there a way to be faithful to truth without becoming a martyr?',
        nextNodeId: 'node_5',
      ),
      DialogueNode(
        id: 'node_4b',
        speaker: 'philosopher',
        textZh:
            '也许你比苏格拉底更务实。活着确实能帮更多人。但这里有一个陷阱：当你决定"暂时不说真话"的时候，你会不会慢慢习惯沉默？当你在阳光和洞穴之间来回走时，你会不会开始分不清哪个才是你真正的世界？',
        textEn:
            'Perhaps you\'re more pragmatic than Socrates. Staying alive does let you help more people. But here\'s a trap: when you decide to "temporarily not speak the truth," might you slowly get used to silence? Moving back and forth between sunlight and cave, might you lose track of which is truly your world?',
        nextNodeId: 'node_5',
      ),
      // Final convergence
      DialogueNode(
        id: 'node_5',
        speaker: 'philosopher',
        textZh:
            '这就是洞穴寓言真正想说的事。它不只是一个认识论的寓言——它是一个关于责任的故事。\n\n看到真相的人，要不要回去？回去的代价是什么？不回去的代价又是什么？\n\n两千多年了，没有人能给出一个让所有人满意的答案。正因为没有简单的答案，这个问题才值得每一代人重新去思考。',
        textEn:
            'This is what the Allegory of the Cave truly wants to say. It\'s not just an epistemological parable — it\'s a story about responsibility.\n\nShould those who\'ve seen the truth go back? What\'s the cost of returning? What\'s the cost of not returning?\n\nFor over two thousand years, no one has given an answer that satisfies everyone. But Plato believed: precisely because there\'s no simple answer, this question deserves to be rethought by every generation.',
        isEndNode: true,
      ),
    ],
    methodSummaryZh:
        '你刚刚经历了一个哲学思维的核心过程：从直觉出发，通过不断追问，发现每个选择都有代价。哲学不是给你答案——而是帮你看清问题的全貌。',
    methodSummaryEn:
        'You just experienced a core process of philosophical thinking: starting from intuition, through relentless questioning, discovering that every choice has its cost. Philosophy doesn\'t give you answers — it helps you see the full picture of the question.',
    opponentPreview: OpponentPreview(
      nameZh: '亚里士多德',
      nameEn: 'Aristotle',
      textZh:
          '我敬爱我的老师，但我更敬爱真理。他总说真实在别处、在什么"理型世界"里。可我看到的是：真实就在眼前这个世界的每一棵树、每一块石头里。与其拉人走出洞穴，不如教他们睁开眼看清眼前的东西。',
      textEn:
          'I love my teacher, but I love truth more. He always says reality is elsewhere, in some "world of Forms." But what I see is: reality is right here, in every tree and every stone before our eyes. Rather than dragging people out of caves, teach them to open their eyes to what\'s right in front of them.',
    ),
  ),

  // ─── Step 4: Reflection ───
  reflection: Reflection(
    questionZh:
        '柏拉图认为看到真相的人有责任回去拯救洞穴中的人，苏格拉底为此付出了生命。但今天我们说要"尊重每个人的观点"。你怎么看？',
    questionEn:
        'Plato believed those who\'ve seen the truth have a duty to go back and save those in the cave. Socrates gave his life for this. But today we say we should "respect everyone\'s viewpoint." What do you think?',
    stances: [
      ReflectionStance(
        textZh: '应该去拯救，放任无知是更大的不负责',
        textEn:
            'We should try to save them — allowing ignorance is a greater irresponsibility',
      ),
      ReflectionStance(
        textZh: '这本身就是傲慢，没人有资格替别人定义真相',
        textEn:
            'This is arrogance itself — no one has the right to define truth for others',
      ),
    ],
    xpReward: 20,
  ),

  // ─── Step 5: Quiz ───
  quiz: [
    QuizQuestion(
      questionZh: '在洞穴寓言中，墙上的"影子"象征什么？',
      questionEn:
          'In the Allegory of the Cave, what do the "shadows" on the wall symbolize?',
      options: [
        QuizOption(textZh: '人们的梦境', textEn: 'People\'s dreams'),
        QuizOption(
          textZh: '人们通过感官接触到的表象世界',
          textEn: 'The world of appearances perceived through the senses',
        ),
        QuizOption(textZh: '哲学家的理论', textEn: 'Philosophers\' theories'),
        QuizOption(
          textZh: '古希腊的宗教信仰',
          textEn: 'Ancient Greek religious beliefs',
        ),
      ],
      correctIndex: 1,
      explanationZh:
          '影子代表我们通过感官感知到的日常世界——柏拉图认为这只是真实世界的投影，不是真实本身。',
      explanationEn:
          'The shadows represent the everyday world we perceive through our senses — Plato believed this is merely a projection of the real world, not reality itself.',
    ),
    QuizQuestion(
      questionZh: '洞穴外面的"太阳"在柏拉图的哲学中象征什么？',
      questionEn:
          'What does the "sun" outside the cave symbolize in Plato\'s philosophy?',
      options: [
        QuizOption(textZh: '知识', textEn: 'Knowledge'),
        QuizOption(textZh: '自由', textEn: 'Freedom'),
        QuizOption(
          textZh: '善的理念（the Form of the Good）',
          textEn: 'The Form of the Good',
        ),
        QuizOption(textZh: '宗教信仰中的神', textEn: 'God in religious belief'),
      ],
      correctIndex: 2,
      explanationZh:
          '太阳象征"善的理念"——柏拉图认为它是所有真理和存在的终极源头，就像太阳是所有光和生命的源头。',
      explanationEn:
          'The sun symbolizes the Form of the Good — Plato believed it is the ultimate source of all truth and existence, just as the sun is the source of all light and life.',
    ),
    QuizQuestion(
      questionZh: '走出洞穴的囚徒回到洞穴后，其他囚徒对他的态度是？',
      questionEn:
          'When the freed prisoner returns to the cave, how do the other prisoners react?',
      options: [
        QuizOption(textZh: '崇拜他，尊他为领袖', textEn: 'Worship him as a leader'),
        QuizOption(
          textZh: '嘲笑他，认为他变蠢了',
          textEn: 'Mock him, thinking he\'s become stupid',
        ),
        QuizOption(
          textZh: '好奇地跟他一起出去',
          textEn: 'Curiously follow him outside',
        ),
        QuizOption(textZh: '冷淡无视', textEn: 'Coldly ignore him'),
      ],
      correctIndex: 1,
      explanationZh:
          '其他囚徒嘲笑他——因为他回到黑暗中反而看不清影子了。柏拉图暗示：追求真理的人往往不被理解，甚至被敌视。苏格拉底的命运正是如此。',
      explanationEn:
          'The other prisoners mock him — because back in the dark, he can no longer see the shadows clearly. Plato implies: those who pursue truth are often misunderstood, even met with hostility. This was exactly Socrates\' fate.',
    ),
    QuizQuestion(
      questionZh: '柏拉图写洞穴寓言的核心目的是什么？',
      questionEn:
          'What is the core purpose of Plato\'s Allegory of the Cave?',
      options: [
        QuizOption(
          textZh: '批评古希腊的政治制度',
          textEn: 'To criticize ancient Greek political systems',
        ),
        QuizOption(
          textZh: '说明大多数人生活在表象中，真正的知识需要艰苦的追寻',
          textEn:
              'To show that most people live among appearances, and true knowledge requires arduous pursuit',
        ),
        QuizOption(textZh: '宣传宗教信仰', textEn: 'To promote religious belief'),
        QuizOption(
          textZh: '证明感官经验完全不可靠',
          textEn: 'To prove sensory experience is completely unreliable',
        ),
      ],
      correctIndex: 1,
      explanationZh:
          '洞穴寓言的核心是认识论：我们日常接触的只是"影子"（表象），真正的知识需要走出舒适区，经历痛苦的思考过程才能获得。柏拉图不是说感官完全不可靠，而是说它们不够——我们需要理性去认识更深层的真实。',
      explanationEn:
          'The cave allegory is fundamentally about epistemology: our daily experience consists of "shadows" (appearances), and true knowledge requires stepping out of comfort zones and enduring painful thinking. Plato doesn\'t say senses are completely unreliable — just that they\'re insufficient. We need reason to grasp deeper reality.',
    ),
  ],
);
