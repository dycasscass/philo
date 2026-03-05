import '../../../models/lesson.dart';

const platoLesson3Republic = Lesson(
  id: 'plato_republic',
  titleZh: '理想国 — 谁应该统治？',
  titleEn: 'The Republic — Who Should Rule?',
  philosopherId: 'plato',

  // ─── Step 1: Thought Experiment ───
  thoughtExperiment: ThoughtExperiment(
    scenarioZh:
        '一个城市花了大钱建了一座现代艺术博物馆。开馆一年后，大部分市民觉得看不懂，认为浪费钱，要求拆掉改建商场。',
    scenarioEn:
        'A city spent a fortune building a modern art museum. A year after opening, most residents find it incomprehensible, consider it a waste of money, and demand it be demolished and replaced with a shopping mall.',
    choicesHeadingZh: '你觉得应该拆掉商场吗？',
    choicesHeadingEn: 'Do you think the mall should be demolished?',
    choices: [
      ExperimentChoice(
        textZh: '应该，大部分人的需求更重要。',
        textEn: 'Yes. The needs of the majority matter more.',
        transitionZh:
            '你尊重多数人的声音。但柏拉图会问你：如果多数人看到的只是影子呢？接下来看看柏拉图如何把洞穴寓言变成一套政治主张。',
        transitionEn:
            'You respect the voice of the majority. But Plato would ask: what if what the majority sees are merely shadows? Let\'s see how Plato turned the cave allegory into a political philosophy.',
      ),
      ExperimentChoice(
        textZh: '不应该，大众不懂，不代表它没价值。',
        textEn:
            'Don\'t change it. Just because the public doesn\'t understand it doesn\'t mean it has no value.',
        transitionZh:
            '你觉得有些东西的价值不该由多数人决定。柏拉图会非常赞同你，而且他更进一步：他认为整个城邦的治理都不该由多数人说了算。',
        transitionEn:
            'You believe some things\' value shouldn\'t be determined by the majority. Plato would strongly agree, and he goes further: he believed the entire governance of the city-state shouldn\'t be decided by the majority.',
      ),
    ],
    commonTransitionZh: '',
    commonTransitionEn: '',
  ),

  // ─── Step 2: Core Teaching ───
  teaching: Teaching(
    backgroundZh:
        '前两节课，我们发现了两件事：\n\n大多数人活在洞穴里，把影子当真实。而真正的实在，是洞穴外那个完美的理型世界。\n\n现在柏拉图要再往前一步。既然大多数人看不到真实，那：\n\n谁来做决定？',
    backgroundEn:
        'In the previous two lessons, we discovered two things:\n\nMost people live in the cave, mistaking shadows for reality. The true reality is the perfect world of Forms outside the cave.\n\nNow Plato takes one step further. Since most people can\'t see reality, then:\n\nWho gets to make the decisions?',
    steps: [
      // Layer 2: 哲学王
      TeachingStep(
        contentZh:
            '柏拉图的回答：让看到真实的人来统治。他把这种人叫做"哲学王"。\n\n哲学王不是聪明人，不是专家，不是有经验的长者。柏拉图的定义非常严格：经过几十年系统训练，最终认识了"善"的理型的人。\n\n他设计了一套完整的教育方案：从音乐体育到数学天文，最后是辩证法。层层筛选，能走到终点的极少数人，才有资格统治。',
        contentEn:
            'Plato\'s answer: let those who can see reality rule. He called such people "philosopher kings."\n\nA philosopher king is not simply a smart person, an expert, or an experienced elder. Plato\'s definition is very strict: someone who has undergone decades of systematic training and ultimately grasped the Form of the Good.\n\nHe designed a complete educational program: from music and athletics to mathematics and astronomy, culminating in dialectics. Through layer upon layer of selection, only the very few who reach the end are qualified to rule.',
        extraExplanationZh:
            '想象一群人在争论一道数学题。有人猜3，有人猜5，有人说投票决定。柏拉图会说：答案就是答案，只有真正懂数学的人知道。他觉得"什么对城邦好"也一样，不是观点之争，有客观的正确答案，只有哲学家能看到。',
        extraExplanationEn:
            'Imagine a group arguing over a math problem. Someone guesses 3, another guesses 5, someone suggests voting on it. Plato would say: the answer is the answer — only someone who truly understands math knows it. He felt "what\'s good for the city-state" works the same way: it\'s not a matter of opinion, there\'s an objectively correct answer, and only philosophers can see it.',
      ),
      // Layer 3: 正义是什么
      TeachingStep(
        contentZh:
            '那普通人怎么办？\n\n柏拉图把城邦分三层：统治者（哲学王）靠智慧决策，护卫者靠勇气保卫，生产者靠节制劳作。\n\n正义就是每个部分做好自己的事，不越界。鞋匠好好做鞋，不要想着治国。哲学家专心治国，不要想着经商。\n\n个人灵魂也一样：理性、意志、欲望，三者各安其位，人就是正义的。',
        contentEn:
            'So what about ordinary people?\n\nPlato divided the city-state into three layers: rulers (philosopher kings) who govern through wisdom, guardians who protect through courage, and producers who work through temperance.\n\nJustice means each part does its own job without overstepping. The shoemaker makes shoes well without thinking about ruling. The philosopher governs without thinking about commerce.\n\nThe individual soul works the same way: reason, spirit, and appetite — when each stays in its place, the person is just.',
        extraExplanationZh:
            '就像一个公司，实习生定战略，CEO扫地，一定乱套。不是谁更"高级"，而是每个位置需要不同能力，硬换就出问题。当然批评者会问：谁来决定你属于哪个阶层？万一分错了呢？',
        extraExplanationEn:
            'It\'s like a company where the intern sets strategy and the CEO sweeps floors — chaos is guaranteed. It\'s not about who\'s "higher rank," but that each position requires different abilities, and forcing a swap causes problems. Of course, critics would ask: who decides which class you belong to? What if they get it wrong?',
      ),
      // Layer 4: 逻辑链
      TeachingStep(
        contentZh:
            '注意柏拉图的逻辑链：\n\n大多数人看到的不是真实（洞穴寓言）→ 存在更高的真实世界（理型论）→ 只有少数人能认识那个世界（哲学王）→ 应该由这些少数人来统治（理想国）\n\n三课的内容在这里合成了完整体系。从认识论到政治哲学，柏拉图一步步推出了结论：民主是危险的，因为它把决定权交给了看不到真实的人。',
        contentEn:
            'Notice Plato\'s chain of logic:\n\nMost people don\'t see reality (Allegory of the Cave) → A higher reality exists (Theory of Forms) → Only a few can perceive that world (philosopher kings) → These few should rule (The Republic)\n\nThe content of all three lessons comes together into a complete system. From epistemology to political philosophy, Plato builds his conclusion step by step: democracy is dangerous because it gives decision-making power to those who cannot see reality.',
      ),
      // Layer 5: 叙拉古的故事
      TeachingStep(
        contentZh:
            '柏拉图不是在书斋里空想。他真去试了。\n\n公元前388年左右，他前往西西里岛的叙拉古城，希望影响统治者。他去了三次。\n\n第一次，惹怒了老暴君狄奥尼索斯一世，差点被卖为奴隶。第二次，老暴君死了，他去教育年轻的狄奥尼索斯二世，年轻暴君根本无心学习。第三次再去，再次失败，一度被软禁。\n\n哲学王的理想，在现实面前彻底粉碎了。\n\n柏拉图晚年写了《法律篇》，开始接受法治和混合政体。等于默认了：找不到哲学王，退而求其次，靠制度约束。',
        contentEn:
            'Plato wasn\'t just theorizing in his study. He actually tried it.\n\nAround 388 BC, he traveled to Syracuse in Sicily, hoping to influence the ruler. He went three times.\n\nThe first time, he angered the old tyrant Dionysius I and was nearly sold into slavery. The second time, the old tyrant had died, and he went to educate the young Dionysius II, who had no interest in learning. The third time, he failed again and was briefly placed under house arrest.\n\nThe ideal of the philosopher king was completely shattered in the face of reality.\n\nIn his later years, Plato wrote the Laws, accepting rule of law and mixed government. He essentially conceded: if you can\'t find a philosopher king, the next best thing is institutional constraints.',
      ),
    ],
    coreInsightZh: '',
    coreInsightEn: '',
    modernAnalogyZh:
        '哲学王听起来虽然很遥远，但这些问题今天依然存在。\n\n气候科学家说必须减排，选民不愿承担经济代价。公共卫生专家说必须封控，市民反对限制自由。经济学家说某政策长期有利，但短期会让很多人失业。\n\n每次这样的冲突，柏拉图的问题都在回响：让看到真实的人做决定，还是让所有人一起选？',
    modernAnalogyEn:
        'Though philosopher kings sound remote, these questions are still alive today.\n\nClimate scientists say emissions must be cut, but voters won\'t bear the economic cost. Public health experts say lockdowns are necessary, but citizens oppose restrictions on freedom. Economists say a policy is beneficial long-term, but it will cost many people their jobs short-term.\n\nEvery time such conflicts arise, Plato\'s question echoes: should those who see the truth make the decisions, or should everyone choose together?',
    legacyZh: '',
    legacyEn: '',
  ),

  // ─── Step 3: Dialogue ───
  dialogue: Dialogue(
    startNodeId: 'node_1',
    nodes: [
      // Round 1
      DialogueNode(
        id: 'node_1',
        speaker: 'philosopher',
        textZh:
            '你已经看到了我的方案。那我问你：你觉得普通人有能力判断什么对城邦是好的吗？',
        textEn:
            'You\'ve seen my proposal. So let me ask you: do you think ordinary people have the ability to judge what\'s good for the city-state?',
        choices: [
          DialogueChoice(
            textZh: '有。每个人都有判断力，只是程度不同。',
            textEn:
                'Yes. Everyone has judgment — it\'s just a matter of degree.',
            nextNodeId: 'node_2a',
          ),
          DialogueChoice(
            textZh: '大部分时候没有。很多人确实看不到全局。',
            textEn:
                'Most of the time, no. Many people truly can\'t see the big picture.',
            nextNodeId: 'node_2b',
          ),
        ],
      ),

      // Round 2a (chose "有判断力")
      DialogueNode(
        id: 'node_2a',
        speaker: 'philosopher',
        textZh:
            '你对人的信心让我想起年轻时的自己。但你还记得洞穴吗？那些囚徒不蠢，他们只是一辈子没见过阳光。你让一个从没见过光的人去描述太阳，他能说出什么？\n\n我换个方式问。假设你生了重病，你会怎么办？',
        textEn:
            'Your faith in people reminds me of my younger self. But do you remember the cave? Those prisoners aren\'t stupid — they\'ve simply never seen sunlight. If you ask someone who\'s never seen light to describe the sun, what could they say?\n\nLet me put it differently. Suppose you fell seriously ill — what would you do?',
        choices: [
          DialogueChoice(
            textZh: '找最好的医生，听他的。',
            textEn: 'Find the best doctor and follow their advice.',
            nextNodeId: 'node_3aa',
          ),
          DialogueChoice(
            textZh: '问身边的人，综合大家的意见。',
            textEn:
                'Ask the people around me and weigh everyone\'s opinions.',
            nextNodeId: 'node_3ab',
          ),
        ],
      ),

      // Round 2b (chose "大部分没有")
      DialogueNode(
        id: 'node_2b',
        speaker: 'philosopher',
        textZh:
            '很好，你比很多人诚实。但我想再推你一步。你说大多数人看不到全局，那你自己呢？你是站在洞穴外面的人，还是只不过比旁边的囚徒多转了一下头？',
        textEn:
            'Good — you\'re more honest than most. But let me push you further. You say most people can\'t see the big picture. What about you? Are you standing outside the cave, or have you merely turned your head a bit more than the prisoner next to you?',
        choices: [
          DialogueChoice(
            textZh: '我可能也在洞穴里。',
            textEn: 'I\'m probably in the cave too.',
            nextNodeId: 'node_3ba',
          ),
          DialogueChoice(
            textZh: '我至少比大多数人看得更清楚。',
            textEn: 'I can see more clearly than most, at least.',
            nextNodeId: 'node_3bb',
          ),
        ],
      ),

      // Round 3: A→A (找医生)
      DialogueNode(
        id: 'node_3aa',
        speaker: 'philosopher',
        textZh:
            '你看，你自己就证明了我的观点。命悬一线的时候，你不会去搞什么投票，你会去找那个真正懂的人。那我问你，治理一个城邦，千万人的命运，难道不比治你一个人的病更重大？凭什么治病要听行家的，治国反倒人人都能插嘴？',
        textEn:
            'See — you just proved my point. When your life is on the line, you don\'t hold a vote; you find someone who truly knows. So let me ask: governing a city-state, the fate of millions — isn\'t that far more significant than treating one person\'s illness? Why should medicine require an expert, but governance allow everyone to chime in?',
        choices: [
          DialogueChoice(
            textZh: '不一样。治病有对错，治国没有标准答案。',
            textEn:
                'It\'s different. Medicine has right and wrong answers; governance doesn\'t have a standard answer.',
            nextNodeId: 'node_4_democracy',
          ),
          DialogueChoice(
            textZh: '你说得对，我没法反驳。',
            textEn: 'You\'re right. I can\'t argue with that.',
            nextNodeId: 'node_4_agree',
          ),
        ],
      ),

      // Round 3: A→B (综合意见)
      DialogueNode(
        id: 'node_3ab',
        speaker: 'philosopher',
        textZh:
            '连命都愿意交给众人来定，你是我见过最彻底的民主信徒。但我必须告诉你一件事。雅典，我的城邦，它的民主制度投票处死了苏格拉底。那是我这辈子遇到过最好的人。五百个人举手，多数人说他该死，他就喝下了毒酒。\n\n你现在还觉得大家商量着来总是靠谱的？',
        textEn:
            'You\'d even entrust your life to the crowd — you\'re the most thorough democrat I\'ve ever met. But I must tell you something. Athens, my city-state, its democracy voted to execute Socrates. He was the best person I ever knew. Five hundred people raised their hands, the majority said he should die, and he drank the hemlock.\n\nDo you still think collective decision-making is always reliable?',
        choices: [
          DialogueChoice(
            textZh: '那是一次错误，不能因此否定民主。',
            textEn:
                'That was a mistake. You can\'t reject democracy because of one error.',
            nextNodeId: 'node_4_democracy',
          ),
          DialogueChoice(
            textZh: '这确实动摇了我。',
            textEn: 'That does shake my conviction.',
            nextNodeId: 'node_4_agree',
          ),
        ],
      ),

      // Round 3: B→A (也在洞穴里)
      DialogueNode(
        id: 'node_3ba',
        speaker: 'philosopher',
        textZh:
            '（笑了）好。承认自己在洞穴里，这需要勇气。苏格拉底说过"我知道我不知道"，你身上有他的影子。\n\n但这就麻烦了。如果你自己也在洞穴里，你拿什么去判断谁是那个走出去的人？你怎么知道站在你面前的哲学王是真的看见了太阳，还是另一个囚徒在吹牛？',
        textEn:
            '(Laughs) Good. Admitting you\'re in the cave takes courage. Socrates said "I know that I know nothing" — I see his shadow in you.\n\nBut this creates a problem. If you\'re also in the cave, how can you judge who has walked out? How do you know whether the philosopher king standing before you has truly seen the sun, or is just another prisoner boasting?',
        choices: [
          DialogueChoice(
            textZh: '确实没法判断。哲学王方案有根本漏洞。',
            textEn:
                'Indeed, there\'s no way to judge. The philosopher king scheme has a fundamental flaw.',
            nextNodeId: 'node_4_flaw',
          ),
          DialogueChoice(
            textZh: '虽然难判断，但总有人比其他人更接近真理。',
            textEn:
                'It\'s hard to judge, but some people are always closer to truth than others.',
            nextNodeId: 'node_4_agree',
          ),
        ],
      ),

      // Round 3: B→B (看得更清)
      DialogueNode(
        id: 'node_3bb',
        speaker: 'philosopher',
        textZh:
            '你对自己很有把握。但我在叙拉古见过一个人，年轻的暴君狄奥尼索斯二世，他也觉得自己比所有人看得清楚。我这辈子见过的每一个暴君都觉得自己是哲学王。\n\n所以我问你，真正的智慧和自以为是，你怎么分得开？',
        textEn:
            'You\'re quite confident in yourself. But in Syracuse I met a man — the young tyrant Dionysius II — who also thought he could see more clearly than everyone. Every tyrant I\'ve met in my life believed himself to be a philosopher king.\n\nSo I ask you: how do you distinguish genuine wisdom from mere self-assurance?',
        choices: [
          DialogueChoice(
            textZh: '看行动和结果，不是看他自己怎么说。',
            textEn:
                'By actions and results, not by what someone claims about themselves.',
            nextNodeId: 'node_4_practice',
          ),
          DialogueChoice(
            textZh: '也许根本分不开。这正是哲学王的危险。',
            textEn:
                'Perhaps you can\'t tell them apart. That\'s precisely the danger of the philosopher king.',
            nextNodeId: 'node_4_flaw',
          ),
        ],
      ),

      // Round 4: 民主有缺陷但仍然必要
      DialogueNode(
        id: 'node_4_democracy',
        speaker: 'philosopher',
        textZh:
            '你明明看到了民主的裂缝，但你还是选它。我不是不理解你。你选民主，说到底不是因为相信众人的智慧，是因为你不敢把命运交给任何一个人。这是清醒，但也是一种认命。\n\n你愿意接受这个代价吗？',
        textEn:
            'You\'re stubborn. You clearly see the cracks in democracy, but you still choose it. I don\'t blame you. At the end of the day, you choose democracy not because you trust the wisdom of the crowd, but because you don\'t dare entrust your fate to any single person. That\'s clear-headed, but it\'s also a kind of resignation.\n\nAre you willing to accept that cost?',
        choices: [
          DialogueChoice(
            textZh: '愿意。这个代价比把权力交给一个人小。',
            textEn:
                'Yes. That cost is smaller than handing power to one person.',
            nextNodeId: 'node_5_question',
          ),
          DialogueChoice(
            textZh: '你说得我有点动摇了。',
            textEn: 'You\'re starting to shake my conviction.',
            nextNodeId: 'node_5_agree',
          ),
        ],
      ),

      // Round 4: 柏拉图有道理
      DialogueNode(
        id: 'node_4_agree',
        speaker: 'philosopher',
        textZh:
            '你能走到这一步，我很高兴。但最难的部分来了。你既然承认有人看得比你远，那逻辑上只有一条路。\n\n你要服从他。不是跟他商量，不是给他提意见，是把你的判断放下，听他的。\n\n你还跟得上吗？',
        textEn:
            'I\'m glad you\'ve come this far. But here comes the hardest part. Since you admit someone can see further than you, logically there\'s only one path.\n\nYou must obey them. Not consult with them, not offer your opinions — set aside your judgment and follow theirs.\n\nCan you still follow?',
        choices: [
          DialogueChoice(
            textZh: '跟不上。有道理是一回事，让我完全服从是另一回事。',
            textEn:
                'No. Agreeing in principle is one thing; complete submission is another.',
            nextNodeId: 'node_5_question',
          ),
          DialogueChoice(
            textZh: '如果他真的看到了善，我愿意。',
            textEn:
                'If he has truly seen the Good, I\'m willing.',
            nextNodeId: 'node_5_agree',
          ),
        ],
      ),

      // Round 4: 哲学王有根本漏洞
      DialogueNode(
        id: 'node_4_flaw',
        speaker: 'philosopher',
        textZh:
            '你戳中了最疼的地方。如果没有人能可靠地认出哲学王，我的整座城邦就建在流沙上。\n\n我去了三次叙拉古，三次都是一身狼狈地回来。也许你是对的。但我还是想问你一个问题：就算永远造不出来，知道最好的城邦长什么样，有没有意义？',
        textEn:
            'You\'ve hit the sorest spot. If no one can reliably identify the philosopher king, my entire city is built on sand.\n\nI went to Syracuse three times, and came back humiliated every time. Perhaps you\'re right. But I still want to ask you: even if it can never be built, is there value in knowing what the best city-state looks like?',
        choices: [
          DialogueChoice(
            textZh: '有。理想就像灯塔，走不到也能照路。',
            textEn:
                'Yes. An ideal is like a lighthouse — you can\'t reach it, but it still lights the way.',
            nextNodeId: 'node_5_agree',
          ),
          DialogueChoice(
            textZh: '没有。造不出来的东西想它干什么。',
            textEn:
                'No. What\'s the point of imagining something that can never be built?',
            nextNodeId: 'node_5_question',
          ),
        ],
      ),

      // Round 4: 实践检验
      DialogueNode(
        id: 'node_4_practice',
        speaker: 'philosopher',
        textZh:
            '拿结果说话，很实在。但我问你：如果哲学王推行一个政策，要二十年才能见效，但民众五年就坐不住了，你听谁的？\n\n真正看得远的决定，做出来的头几年往往是挨骂的。你靠"看结果"，看的是哪一年的结果？',
        textEn:
            'Judging by results — very practical. But let me ask you: if a philosopher king enacts a policy that takes twenty years to bear fruit, but the public loses patience after five, who do you listen to?\n\nTruly far-sighted decisions are often criticized in their first years. When you "judge by results," which year\'s results are you looking at?',
        choices: [
          DialogueChoice(
            textZh: '那就把检验的时间拉长。',
            textEn: 'Then extend the evaluation period.',
            nextNodeId: 'node_5_question',
          ),
          DialogueChoice(
            textZh: '你说服我了。结果确实不是好标准。',
            textEn:
                'You\'ve convinced me. Results really aren\'t a good standard.',
            nextNodeId: 'node_5_agree',
          ),
        ],
      ),

      // Round 5: 偏质疑版 (Aristotle appears)
      DialogueNode(
        id: 'node_5_question',
        speaker: 'narrator',
        textZh:
            '亚里士多德：老师，容我说一句。看起来你这位朋友没那么容易被说动。\n\n我倒觉得他的怀疑方向是对的，不过理由还可以更充分。问题不只是信不信得过哲学王。问题是，把这么大的权力放在任何一个人身上，不管他有多好，本质上都是一场豪赌。法律笨一点，慢一点，但法律不会被权力喂大了胃口。',
        textEn:
            'Aristotle: Teacher, if I may. It seems your friend here isn\'t so easily swayed.\n\nI think his skepticism is in the right direction, though his reasoning could be stronger. The issue isn\'t just whether we can trust a philosopher king. The issue is that placing so much power in any single person, no matter how good, is fundamentally a gamble. The law may be clumsy and slow, but the law won\'t develop an appetite fed by power.',
        nextNodeId: 'node_5_question_plato',
      ),
      DialogueNode(
        id: 'node_5_question_plato',
        speaker: 'philosopher',
        textZh:
            '你总是这样，我的学生。你看到了脚下的土地，却不肯抬头看天上的星星。',
        textEn:
            'You always do this, my student. You see the ground beneath your feet, but refuse to look up at the stars.',
        choices: [
          DialogueChoice(
            textZh: '我更同意柏拉图。理想虽难实现，但我们需要最高标准。',
            textEn:
                'I agree more with Plato. Ideals may be hard to achieve, but we need the highest standard.',
            nextNodeId: 'node_end',
          ),
          DialogueChoice(
            textZh: '我更同意亚里士多德。制度比依赖某个人可靠。',
            textEn:
                'I agree more with Aristotle. Institutions are more reliable than depending on any individual.',
            nextNodeId: 'node_end',
          ),
        ],
      ),

      // Round 5: 偏同意版 (Aristotle appears)
      DialogueNode(
        id: 'node_5_agree',
        speaker: 'narrator',
        textZh:
            '亚里士多德：老师，容我说一句。你这位朋友似乎被你说服了，但有些话我不得不讲。\n\n我跟着你学了二十年，我从来没见过什么理型世界。如果连我都没见过，凭什么相信你的哲学王就一定见过？再说了，就算他今天看到了善，权力这个东西会改变人。今天的哲学王，三年后可能就是暴君。\n\n比起找一个完美的人，不如花力气建一套过得去的制度。法律不完美，但法律不会变质。',
        textEn:
            'Aristotle: Teacher, if I may. Your friend here seems convinced, but there are things I must say.\n\nI studied under you for twenty years, and I never once saw any world of Forms. If even I haven\'t seen it, why should we trust that your philosopher king has? Besides, even if he sees the Good today, power changes people. Today\'s philosopher king could be tomorrow\'s tyrant.\n\nRather than searching for a perfect person, better to spend that effort building a decent system. The law isn\'t perfect, but the law won\'t corrupt.',
        nextNodeId: 'node_5_agree_plato',
      ),
      DialogueNode(
        id: 'node_5_agree_plato',
        speaker: 'philosopher',
        textZh:
            '你看到了脚下的土地，却不肯抬头看天上的星星。你从我这里学到了一切，却否认了最重要的东西。',
        textEn:
            'You see the ground beneath your feet, but refuse to look up at the stars. You learned everything from me, yet you deny the most important thing.',
        choices: [
          DialogueChoice(
            textZh: '我更同意柏拉图。理想虽难实现，但我们需要最高标准。',
            textEn:
                'I agree more with Plato. Ideals may be hard to achieve, but we need the highest standard.',
            nextNodeId: 'node_end',
          ),
          DialogueChoice(
            textZh: '我更同意亚里士多德。制度比依赖某个人可靠。',
            textEn:
                'I agree more with Aristotle. Institutions are more reliable than depending on any individual.',
            nextNodeId: 'node_end',
          ),
        ],
      ),

      // End node
      DialogueNode(
        id: 'node_end',
        speaker: 'narrator',
        textZh: '',
        textEn: '',
        isEndNode: true,
      ),
    ],
    methodSummaryZh: '',
    methodSummaryEn: '',
    opponentPreview: null,
  ),

  // ─── Step 4: Reflection ───
  reflection: Reflection(
    questionZh:
        '当专家的判断和大多数人的意愿冲突时，谁应该有最终决定权？',
    questionEn:
        'When experts\' judgment conflicts with the will of the majority, who should have the final say?',
    stances: [
      ReflectionStance(
        textZh: '专家。有些事需要专业知识才能判断对错。',
        textEn:
            'Experts. Some matters require professional knowledge to judge right from wrong.',
      ),
      ReflectionStance(
        textZh: '大多数人。决定影响所有人的生活，不能由少数人包办。',
        textEn:
            'The majority. Decisions that affect everyone\'s lives can\'t be made by a few.',
      ),
    ],
    xpReward: 20,
  ),

  // ─── Step 5: Quiz ───
  quiz: [
    QuizQuestion(
      questionZh: '柏拉图认为哲学王最重要的资质是什么？',
      questionEn:
          'According to Plato, what is the most important qualification of a philosopher king?',
      options: [
        QuizOption(
          textZh: '对"善"的理型的认识',
          textEn: 'Knowledge of the Form of the Good',
        ),
        QuizOption(
          textZh: '不贪恋权力的品格',
          textEn: 'A character that doesn\'t crave power',
        ),
        QuizOption(
          textZh: '丰富的执政经验',
          textEn: 'Rich governing experience',
        ),
        QuizOption(
          textZh: '让人民信服的能力',
          textEn: 'The ability to win people\'s trust',
        ),
      ],
      correctIndex: 0,
      explanationZh:
          'B也是柏拉图强调的特质，但那是"适合统治"的表现，不是核心资质。整个体系建立在理型论上：只有认识了善的理型，才知道什么对城邦真正好。C是经验主义标准，D是民主政治家的标准，恰恰是柏拉图不认可的。',
      explanationEn:
          'B is also a trait Plato emphasized, but it\'s a sign of "suitability to rule," not the core qualification. The entire system is built on the Theory of Forms: only by knowing the Form of the Good can one know what\'s truly good for the city-state. C is an empiricist standard, and D is the standard of a democratic politician — precisely what Plato rejects.',
    ),
    QuizQuestion(
      questionZh: '柏拉图所说的"正义"是什么？',
      questionEn: 'What is "justice" according to Plato?',
      options: [
        QuizOption(
          textZh: '所有人拥有平等的权利',
          textEn: 'Equal rights for all people',
        ),
        QuizOption(
          textZh: '多数人的利益最大化',
          textEn: 'Maximizing the interests of the majority',
        ),
        QuizOption(
          textZh: '强者保护弱者',
          textEn: 'The strong protecting the weak',
        ),
        QuizOption(
          textZh: '每个部分做好自己的事，不越界',
          textEn:
              'Each part doing its own job without overstepping',
        ),
      ],
      correctIndex: 3,
      explanationZh:
          'A是现代平等主义的正义观。B是后来功利主义的观点。C是朴素的正义感，柏拉图不反对但这不是他的定义。柏拉图的正义很明确：城邦三个阶层各司其职，灵魂三个部分各安其位。',
      explanationEn:
          'A is the modern egalitarian view of justice. B is the later utilitarian perspective. C is a naive sense of justice — Plato doesn\'t oppose it, but it\'s not his definition. Plato\'s justice is clear: the three classes of the city-state each perform their roles, and the three parts of the soul each stay in their place.',
    ),
    QuizQuestion(
      questionZh: '柏拉图为什么反对民主？',
      questionEn: 'Why did Plato oppose democracy?',
      options: [
        QuizOption(
          textZh: '他认为民主效率太低',
          textEn: 'He thought democracy was too inefficient',
        ),
        QuizOption(
          textZh: '他认为穷人不应该有投票权',
          textEn:
              'He thought the poor shouldn\'t have the right to vote',
        ),
        QuizOption(
          textZh: '他认为民主会把决定权交给不了解真相的人',
          textEn:
              'He thought democracy gives decision-making power to those who don\'t understand the truth',
        ),
        QuizOption(
          textZh: '他认为民主会导致无政府状态',
          textEn: 'He thought democracy leads to anarchy',
        ),
      ],
      correctIndex: 2,
      explanationZh:
          'A是实用层面的批评，不是他的核心理由。B是阶级偏见，柏拉图的反对不基于贫富。D虽然他讨论过政体退化，但不是反对民主的核心原因。C直接对应洞穴寓言和哲学王理论：大多数人看到的是影子，让他们投票决定城邦大事，就像让囚徒决定什么是真实的。',
      explanationEn:
          'A is a practical criticism, not his core reason. B is class prejudice — Plato\'s opposition isn\'t based on wealth. D — while he did discuss the degeneration of regimes, that\'s not the core reason for opposing democracy. C directly corresponds to the cave allegory and philosopher king theory: most people see shadows, and letting them vote on city affairs is like letting prisoners decide what\'s real.',
    ),
    QuizQuestion(
      questionZh: '柏拉图在叙拉古的经历说明了什么？',
      questionEn:
          'What do Plato\'s experiences in Syracuse demonstrate?',
      options: [
        QuizOption(
          textZh: '暴君不可能被教化',
          textEn: 'Tyrants cannot be educated',
        ),
        QuizOption(
          textZh: '哲学王的理论完全错误',
          textEn:
              'The theory of the philosopher king is completely wrong',
        ),
        QuizOption(
          textZh: '柏拉图晚年完全放弃了自己的政治哲学',
          textEn:
              'Plato completely abandoned his political philosophy in later life',
        ),
        QuizOption(
          textZh: '哲学理想在现实政治面前遇到了巨大障碍',
          textEn:
              'Philosophical ideals encountered enormous obstacles in the face of real politics',
        ),
      ],
      correctIndex: 3,
      explanationZh:
          'A太绝对，问题不只是暴君本人。B太绝对，失败不等于理论错误。C不准确，柏拉图在《法律篇》做了妥协，但没有"完全放弃"，他依然认为哲学王是最好的，只是退而求其次接受了法治。',
      explanationEn:
          'A is too absolute — the problem isn\'t just the tyrant himself. B is too absolute — failure doesn\'t mean the theory is wrong. C is inaccurate — Plato compromised in the Laws, but didn\'t "completely abandon" his philosophy. He still believed the philosopher king was ideal, but settled for rule of law as the next best thing.',
    ),
  ],
);
