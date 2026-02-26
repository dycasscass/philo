/// ╔══════════════════════════════════════════════════════════════════╗
/// ║                    课程内容填写模板                              ║
/// ╠══════════════════════════════════════════════════════════════════╣
/// ║  使用方法：                                                     ║
/// ║  1. 复制此文件到对应文件夹，改名                                  ║
/// ║     例：data/worlds/ancient_greece/plato_lesson2_forms.dart     ║
/// ║  2. 只填中文，【】里的内容替换成你的文本                           ║
/// ║  3. 英文留着 'TODO' 不用管，填完后让 Claude 自动翻译              ║
/// ║  4. 对话树结构参考文件底部的设计指南                               ║
/// ╚══════════════════════════════════════════════════════════════════╝

import '../../../models/lesson.dart';

const platoLesson2Forms = Lesson(
  id: 'plato_forms',
  titleZh: '理型论 — “真实“存在于何处？',   // 用 " — " 分隔，前半显示在顶栏，后半显示在开场页
  titleEn: 'TODO',
  philosopherId: 'plato',

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 第一步：思想实验
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //
  // 用生活化场景让学生凭直觉选择，再引出哲学概念
  // 流程：场景(可分段) → 选项 → 回应 → 共同过渡
  //
  thoughtExperiment: ThoughtExperiment(
    // 用 \n\n 分段，每段单独一页显示
    scenarioZh: '''
上一节柏拉图说，我们看到的都是影子，真实在别处。''',
    scenarioEn: 'TODO',
 choicesHeadingZh: '但这引出了一个问题：如果有人一辈子只见过影子，他怎么能意识到那是影子而不是真实？他脑中关于’真实’的概念，是从哪来的？',
    // 2-3 个选项
    choices: [
      ExperimentChoice(
        textZh: '见的影子够多了，自然会开始怀疑',
        textEn: 'TODO',
        transitionZh: '但如果他见过的全部都是影子，他拿什么来怀疑？怀疑需要一个参照物。柏拉图认为，这个参照物不是从经验中来的。',
        transitionEn: 'TODO',
      ),
      ExperimentChoice(
        textZh: '除非他接触过真实，否则不可能知道',
        textEn: 'TODO',
        transitionZh: '但他从出生起就没离开过洞穴。如果他从未接触过真实，这个关于’真实’的隐约感觉又是从哪来的？柏拉图给了一个大胆的回答。',
        transitionEn: 'TODO',
      ),
      ExperimentChoice(
        textZh: '他永远不会意识到，除非有人告诉他',
        textEn: 'TODO',
        transitionZh: '那’告诉他的人’又是怎么知道的？总得有人在某个地方见过真实本身。柏拉图认为，每个人其实都’见过’，只是忘了。',
        transitionEn: 'TODO',
      ),
    ],

    // 不管选了什么都会看到的过渡文字
    commonTransitionZh: '这个问题正是柏拉图理型论的起点：我们心中那些关于’完美’和’真实’的概念，不可能凭空产生。它们一定有一个来源。',
    commonTransitionEn: 'TODO',
  ),

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 第二步：核心教学
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //
  // 流程：背景 → 教学步骤 → 核心洞见 → 现代类比 → 遗产
  //
  teaching: Teaching(
    // 3-5 个教学步骤，逐步展开
    steps: [
      TeachingStep(
        contentZh: '你面前有一张桌子，你觉得再熟悉不过了。但仔细想——在日光下它是棕色的，在台灯下变成深褐色，在阴影里几乎是黑色的。那桌子"真正的颜色"是什么？',
        contentEn: 'TODO',
        // "再解释一下 🤔"按钮的补充说明（可选，不需要就删掉这两行）
        extraExplanationZh: '你从正面看桌子是长方形，从侧面看变成了一条线，从斜上方看是平行四边形。那桌子"真正的形状"到底是哪个？',
        extraExplanationEn: 'TODO',
      ),
      TeachingStep(
        contentZh: '颜色随光线变，形状随角度变，触感随温度变，甚至大小也随距离变。你以为你在看"桌子本身"，但其实你每时每刻感知到的都是不同的东西。那"桌子本身"到底是什么？',
        contentEn: 'TODO',
        extraExplanationZh: '把手放在桌面上，冬天觉得冰凉，夏天觉得温热。桌子没换，但你的感受完全不同。你感知到的到底是桌子的属性，还是你自己感官的反应？',
        extraExplanationEn: 'TODO',
      ),
      TeachingStep(
        contentZh: '如果感官给你的信息一直在变，那它们告诉你的就不是"事物本身"，而是事物在某个瞬间、某个角度、某个条件下的样子——也就是表象。感官能告诉你桌子"看起来"怎样，但告诉不了你桌子"是"什么。',
        contentEn: 'TODO',

        extraExplanationZh: '就像你只能看到一个人在不同场合的表现——在老板面前一个样，在朋友面前一个样，在家里又一个样。你看到了很多个"他"，但"真正的他"是什么？你没法通过这些片段直接拼出来。',
        extraExplanationEn: 'TODO',
      ),
      TeachingStep(
        contentZh: '尽管你永远无法通过感官直接接触到"桌子本身"，但你确信它存在。不管光线怎么变、角度怎么换，你始终知道面前就是"一张桌子"。这个确定性不是来自感官，而是来自你心中已有的某种认识。',
        contentEn: 'TODO',
        extraExplanationZh: '闭上眼睛，你还是知道面前有张桌子。这说明你对"桌子"的认识不完全依赖感官。你心中有一个关于"桌子之所以是桌子"的理解，它比任何一次具体的感知都更稳定。',
        extraExplanationEn: 'TODO',
      ),
      TeachingStep(
        contentZh: '柏拉图说，你心中那个"桌子本身"的概念，不是从感官经验中归纳出来的，而是来自一个更真实的世界。那里存在着一切事物的完美原型——他称之为"理型"。我们眼前的每一张具体的桌子都只是"桌子的理型"的不完美拷贝。理型是永恒的，而拷贝是变化的。',
        contentEn: 'TODO',
        extraExplanationZh: '回忆一下洞穴寓言。墙上的影子就是我们感官接触到的各种表象——不同光线下的颜色、不同角度的形状。洞穴外面阳光下的真实事物就是理型。我们一直在看影子，但影子背后有一个不变的源头。',
        extraExplanationEn: 'TODO',
      ),
      TeachingStep(
        contentZh: '如果这些完美的概念不是从感官经验中来的，那你怎么知道的？柏拉图说：你的灵魂在进入身体之前，曾在理型世界中直接接触过这些完美的原型。你现在所谓的"学习"，不是获取新知识，而是回忆灵魂深处已经知道的东西。',
        contentEn: 'TODO',
        extraExplanationZh: '有没有过这种感觉——学到一个新东西时不是觉得"原来如此"，而是觉得"我好像一直知道这个"？柏拉图会说，那不是错觉，那就是你的灵魂在回忆。',
        extraExplanationEn: 'TODO',
      ),
    ],

    coreInsightZh: '我们看到的世界是不完美的拷贝，完美的原型在理型世界中。真正的知识不是来自感官，而是灵魂对理型的回忆。',
    coreInsightEn: 'TODO',



    modernAnalogyZh: '柏拉图在两千多年前就追问：人类的认知到底从何而来？今天，AI的出现让这个古老的问题重新变得迫切。',
    modernAnalogyEn: 'TODO',

    // 类比互动问题（可选，不需要就把 analogyQuestion 整个删掉）
    analogyQuestion: AnalogyQuestion(
      questionZh: 'AI看了一百万张猫的图片后能认出新的猫。人类只需要看几张就能认出来。AI是在做统计，人类也是吗？还是人类心中有某种AI不具备的东西？',
      questionEn: 'TODO',
      options: [
        AnalogyOption(textZh: '本质一样，人类也是在做模式识别，只是更高效', textEn: 'TODO'),
        AnalogyOption(textZh: '不一样，人类的认知中有某种超越统计的东西', textEn: 'TODO'),
      ],
    ),

    legacyZh: '理型论深刻影响了基督教。"一个完美永恒的世界在上，不完美的现实在下"这个结构几乎原封不动地进入了基督教神学。而"表象背后有没有更深层的实在"这个问题，奠定了整个西方形而上学的基础，至今仍是哲学的核心议题之一。',
    legacyEn: 'TODO',
  ),

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 第三步：对话 / 辩论
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //
  // 对话树结构参考文件底部的设计指南
  //
  dialogue: Dialogue(
    startNodeId: 'n1',
    nodes: [
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      // 第一轮：桌子问题（3选项）
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      DialogueNode(
        id: 'n1',
        speaker: 'philosopher',
        textZh: '你见过无数张桌子——木的、铁的、圆的、方的，没有两张完全相同。但你一眼就能认出它们都是\u201c桌子\u201d。为什么？',
        textEn: 'TODO',
        choices: [
          DialogueChoice(
            textZh: '因为它们有共同特征——都有平面、都有腿、都能放东西',
            textEn: 'TODO',
            nextNodeId: 'n2a',
          ),
          DialogueChoice(
            textZh: '因为\u201c桌子\u201d是人类规定的概念',
            textEn: 'TODO',
            nextNodeId: 'n2b',
          ),
          DialogueChoice(
            textZh: '因为从小就被教会了什么是桌子',
            textEn: 'TODO',
            nextNodeId: 'n2c',
          ),
        ],
      ),

      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      // 第二轮：三条分支各自追问
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      // ── A：共同特征 → 追问石板 ──
      DialogueNode(
        id: 'n2a',
        speaker: 'philosopher',
        textZh: '好，你说它们有共同特征。但一块石板架在两堆砖上，也有平面，也能放东西。它算桌子吗？你心里一定有一个标准在判断\u201c像桌子但不是桌子\u201d。那个标准从哪来的？',
        textEn: 'TODO',
        choices: [
          DialogueChoice(
            textZh: '从经验里总结出来的——见多了自然就有了这个标准',
            textEn: 'TODO',
            nextNodeId: 'n3_induct',
          ),
          DialogueChoice(
            textZh: '这个标准好像在见到桌子之前就有了，经验只是触发了它',
            textEn: 'TODO',
            nextNodeId: 'n3_essence',
          ),
        ],
      ),

      // ── B：人类规定 → 追问跨文化 ──
      DialogueNode(
        id: 'n2b',
        speaker: 'philosopher',
        textZh: '如果只是规定，那为什么全世界不同文化都独立发明了\u201c桌子\u201d这个概念？没有人规定过哈萨克人和玛雅人必须用同一个词来描述同一类东西。为什么他们不约而同地做出了类似的区分？',
        textEn: 'TODO',
        choices: [
          DialogueChoice(
            textZh: '因为人类有类似的需求，类似的需求自然产生类似的分类',
            textEn: 'TODO',
            nextNodeId: 'n3_convention',
          ),
          DialogueChoice(
            textZh: '也许确实有某种超越文化的东西，让所有人做出了相同的判断',
            textEn: 'TODO',
            nextNodeId: 'n3_essence',
          ),
        ],
      ),

      // ── C：从小被教会 → 追问第一个人 ──
      DialogueNode(
        id: 'n2c',
        speaker: 'philosopher',
        textZh: '可是教你的人，又是怎么知道的？追溯到最初，总有一个\u201c第一个人\u201d认出了桌子。那个人没有人教他。他凭什么知道？',
        textEn: 'TODO',
        choices: [
          DialogueChoice(
            textZh: '他是从具体经验中慢慢摸索出来的，后人只是继承了他的总结',
            textEn: 'TODO',
            nextNodeId: 'n3_induct',
          ),
          DialogueChoice(
            textZh: '他可能天生就有这种分辨能力，教育只是唤醒了它',
            textEn: 'TODO',
            nextNodeId: 'n3_intuition',
          ),
        ],
      ),

      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      // 第三轮：四条路径，用"美"深入追问
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      // ── 归纳路径（来自 A1 / C1） ──
      DialogueNode(
        id: 'n3_induct',
        speaker: 'philosopher',
        textZh: '你认为概念是从经验中归纳出来的。那我们来试一个更难的：一朵花很美，一首音乐也很美，一个数学证明也可以很美。它们之间没有任何共同的物理特征。你从什么经验里\u201c归纳\u201d出了\u201c美\u201d？',
        textEn: 'TODO',
        choices: [
          DialogueChoice(
            textZh: '美就是一种主观感受，不需要归纳，每个人感受不同',
            textEn: 'TODO',
            nextNodeId: 'n3i_subj',
          ),
          DialogueChoice(
            textZh: '也许\u201c美\u201d真的不是归纳出来的，它的来源可能跟桌子不一样',
            textEn: 'TODO',
            nextNodeId: 'n3i_not',
          ),
        ],
      ),
      DialogueNode(
        id: 'n3i_subj',
        speaker: 'philosopher',
        textZh: '如果美纯粹是主观的、每个人完全不同，为什么几乎所有文明都觉得星空很美？跨越几千年，人类对美的核心感受惊人地相似。纯粹的主观不应该产生这么多共识。也许有一个\u201c美本身\u201d存在，所有人都在不同程度上感受到了它。',
        textEn: 'TODO',
        nextNodeId: 'n4',
      ),
      DialogueNode(
        id: 'n3i_not',
        speaker: 'philosopher',
        textZh: '你碰到了关键的困难。如果不是归纳，那就意味着你在接触任何美的东西之前，心里已经有了某种关于\u201c美\u201d的认识。这个认识从哪来的？我的回答是：你的灵魂曾经直接见过\u201c美本身\u201d。',
        textEn: 'TODO',
        nextNodeId: 'n4',
      ),

      // ── 本质路径（来自 A2 / B2） ──
      DialogueNode(
        id: 'n3_essence',
        speaker: 'philosopher',
        textZh: '你感觉到有某种超越具体事物的东西。让我们用\u201c美\u201d来检验。一朵花很美，一段旋律很美，一个数学公式很美——它们完全不同，但你用同一个\u201c美\u201d来描述。这个\u201c美\u201d，是存在于这些事物中，还是存在于它们之外？',
        textEn: 'TODO',
        choices: [
          DialogueChoice(
            textZh: '存在于事物中——每个美的东西里都有一份\u201c美\u201d的成分',
            textEn: 'TODO',
            nextNodeId: 'n3e_in',
          ),
          DialogueChoice(
            textZh: '存在于事物之外——这些东西只是触发了我心中已有的某种感受',
            textEn: 'TODO',
            nextNodeId: 'n3e_out',
          ),
        ],
      ),
      DialogueNode(
        id: 'n3e_in',
        speaker: 'philosopher',
        textZh: '如果美存在于花里，那花凋谢了，那份美也跟着消失了吗？但你还记得它美过，你仍然知道什么是美。\u201c美\u201d并没有跟着花一起死去。它一直在某个地方。',
        textEn: 'TODO',
        nextNodeId: 'n4',
      ),
      DialogueNode(
        id: 'n3e_out',
        speaker: 'philosopher',
        textZh: '你离真相只有一步了。如果美不在任何具体的花、音乐、公式里，而是在\u201c某个地方\u201d——那个地方就是我所说的理型世界。你心中关于美的感受，是灵魂对\u201c美的理型\u201d的回忆。',
        textEn: 'TODO',
        nextNodeId: 'n4',
      ),

      // ── 约定路径（来自 B1） ──
      DialogueNode(
        id: 'n3_convention',
        speaker: 'philosopher',
        textZh: '你说是需求驱动了分类。那我给你一个没有实用需求的例子：美。没有人\u201c需要\u201d美来生存，一朵花美不美跟你能不能活下去没有关系。但你就是能感知到美，而且跟地球另一端、另一个时代的人感知到的惊人相似。这种不基于需求的共识，怎么来的？',
        textEn: 'TODO',
        choices: [
          DialogueChoice(
            textZh: '美可能也有进化上的功能，只是我们还不完全理解',
            textEn: 'TODO',
            nextNodeId: 'n3c_evo',
          ),
          DialogueChoice(
            textZh: '美确实不像是需求驱动的，也许有某种更深层的来源',
            textEn: 'TODO',
            nextNodeId: 'n3c_deep',
          ),
        ],
      ),
      DialogueNode(
        id: 'n3c_evo',
        speaker: 'philosopher',
        textZh: '就算审美有进化的成分，你能解释为什么人类觉得数学证明是\u201c美\u201d的吗？一个公式的优雅跟生存完全无关。进化能解释你为什么怕蛇，但很难解释你为什么觉得欧拉公式很美。也许\u201c美\u201d的来源比进化更深。',
        textEn: 'TODO',
        nextNodeId: 'n4',
      ),
      DialogueNode(
        id: 'n3c_deep',
        speaker: 'philosopher',
        textZh: '你开始看到了。当一个现象无法被需求、文化、进化完全解释时，也许该往内心深处找。你对\u201c美\u201d的认识，也许不是后天获得的，而是你本来就有的。',
        textEn: 'TODO',
        nextNodeId: 'n4',
      ),

      // ── 直觉路径（来自 C2） ──
      DialogueNode(
        id: 'n3_intuition',
        speaker: 'philosopher',
        textZh: '你说人天生就有分辨的能力。让我们用\u201c美\u201d来检验这个想法。研究发现，刚出生的婴儿会更长时间地注视对称的面孔。他没学过什么是\u201c美\u201d，但已经在回应美了。而且长大后，人还会觉得数学证明、音乐旋律也很美。这种能力指向的到底是什么？',
        textEn: 'TODO',
        choices: [
          DialogueChoice(
            textZh: '是生物本能，自然选择的结果',
            textEn: 'TODO',
            nextNodeId: 'n3d_bio',
          ),
          DialogueChoice(
            textZh: '这种能力太广泛了，超出了生物本能能解释的范围',
            textEn: 'TODO',
            nextNodeId: 'n3d_beyond',
          ),
        ],
      ),
      DialogueNode(
        id: 'n3d_bio',
        speaker: 'philosopher',
        textZh: '对称面孔也许可以用本能解释。但一个数学家看到简洁的证明时说\u201c这很美\u201d——这跟生存、跟繁衍毫无关系。如果对数学之美的感受也是\u201c本能\u201d，那这种本能指向的到底是什么？也许它指向的不是进化的过去，而是某种更永恒的东西。',
        textEn: 'TODO',
        nextNodeId: 'n4',
      ),
      DialogueNode(
        id: 'n3d_beyond',
        speaker: 'philosopher',
        textZh: '如果对美的感知超出了生物本能能解释的范围，那它一定有一个更深的来源。我的回答是：你的灵魂在进入身体之前，曾在理型世界中直接见过\u201c美本身\u201d。你现在的每一次审美体验，都是那个记忆的回响。',
        textEn: 'TODO',
        nextNodeId: 'n4',
      ),

      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      // 第四轮（收束）：美本身会消失吗
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      DialogueNode(
        id: 'n4',
        speaker: 'philosopher',
        textZh: '最后一个问题。每一朵花都会凋谢，每一首乐曲都会结束，每一张面孔都会老去。美的东西都在消失。但\u201c美本身\u201d——你心中那个让你能认出美的东西——它会消失吗？',
        textEn: 'TODO',
        choices: [
          DialogueChoice(
            textZh: '不会。美的东西来来去去，但\u201c美本身\u201d一直在',
            textEn: 'TODO',
            nextNodeId: 'n4a',
          ),
          DialogueChoice(
            textZh: '会。没有了美的东西，\u201c美\u201d也就不存在了',
            textEn: 'TODO',
            nextNodeId: 'n4b',
          ),
        ],
      ),

      // ── 美本身一直在 ──
      DialogueNode(
        id: 'n4a',
        speaker: 'philosopher',
        textZh: '这就是理型。它不依赖任何花、任何音乐、任何人的存在。它永恒、完美、不变。而你之所以能认出美，是因为你的灵魂曾经直接见过它。你所有的审美体验，都是对那次相遇的回忆。',
        textEn: 'TODO',
        isEndNode: true,
      ),

      // ── 美也会消失 ──
      DialogueNode(
        id: 'n4b',
        speaker: 'philosopher',
        textZh: '那为什么花谢了之后，你还是知道什么是美？如果\u201c美\u201d随着花一起消失了，你应该连这个概念都忘掉才对。但你没有。也许\u201c美\u201d从来不住在花里，它一直住在别处——一个花开花谢都影响不了的地方。',
        textEn: 'TODO',
        isEndNode: true,
      ),
    ],

    methodSummaryZh: '感官只能给你变动的表象，不能给你事物本身。真正的知识来自理型——一切事物的完美原型。学习不是获取新知识，而是回忆灵魂已经知道的东西。',
    methodSummaryEn: 'TODO',

    opponentPreview: OpponentPreview(
      nameZh: '亚里士多德',
      nameEn: 'TODO',
      textZh: '我老师说每张桌子背后都有一个\u2019桌子的理型\u2019。但这解释了什么？你不过是把问题搬到了另一个世界。现在我们不仅要解释桌子，还要解释桌子和理型之间的关系。一个解释如果比被解释的东西还复杂，那就不是好解释。',
      textEn: 'TODO',
    ),
  ),

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 第四步：开放性反思
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  reflection: Reflection(
    questionZh: '数学规律是人类发明的，还是本来就存在等着被发现的？比如圆周率π——它是人造的概念，还是宇宙中本来就有这个东西？',
    questionEn: 'TODO',
    stances: [
      ReflectionStance(textZh: '发明的，数学是人类创造的工具', textEn: 'TODO'),
      ReflectionStance(textZh: '发现的，即使没有人类，π依然存在', textEn: 'TODO'),
    ],
    xpReward: 20,
  ),

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 第五步：测验（3-5题，每题 2-4 个选项）
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  quiz: [
    QuizQuestion(
      questionZh: '柏拉图为什么认为必须存在一个理型世界？',
      questionEn: 'TODO',
      options: [
        QuizOption(textZh: '感官不可靠，需要一个稳定的世界作为认知基础', textEn: 'TODO'),
        QuizOption(textZh: '我们拥有"完美"的概念，但现实中从没有完美的事物，这些概念一定来自别处', textEn: 'TODO'),
        QuizOption(textZh: '现实太混乱，需要一个有秩序的世界来解释它', textEn: 'TODO'),
        QuizOption(textZh: '为了给道德和正义找到一个客观标准', textEn: 'TODO'),
      ],
      correctIndex: 1,
      explanationZh: '理型论的核心出发点是：我们从未见过完美的事物，却拥有完美的概念，这些概念一定有一个来源。其他选项都触及了理型论的部分意义，但不是它最根本的逻辑起点。',
      explanationEn: 'TODO',
    ),

    QuizQuestion(
      questionZh: '在柏拉图看来，我们眼前这个世界和理型世界是什么关系？',
      questionEn: 'TODO',
      options: [
        QuizOption(textZh: '两个独立的世界，各自运行各自的规律', textEn: 'TODO'),
        QuizOption(textZh: '眼前的世界是理型世界的不完美拷贝', textEn: 'TODO'),
        QuizOption(textZh: '理型世界是对眼前世界的抽象概括', textEn: 'TODO'),
        QuizOption(textZh: '两个世界互相依赖，缺一不可', textEn: 'TODO'),
      ],
      correctIndex: 1,
      explanationZh: '柏拉图认为关系是单向的：理型是源头，感官世界是投影。理型不依赖具体事物而存在，但具体事物依赖理型而存在。第三个选项把方向搞反了，第四个选项看似合理，但柏拉图不认为理型需要依赖现实世界。',
      explanationEn: 'TODO',
    ),

    QuizQuestion(
      questionZh: '柏拉图认为理型世界存在于何处？',
      questionEn: 'TODO',
      options: [
        QuizOption(textZh: '在宇宙的某个物理空间中', textEn: 'TODO'),
        QuizOption(textZh: '在人类的大脑中，是思维的产物', textEn: 'TODO'),
        QuizOption(textZh: '独立于物理世界和人类心智之外，是超越时空的实在', textEn: 'TODO'),
        QuizOption(textZh: '在神的意志之中', textEn: 'TODO'),
      ],
      correctIndex: 2,
      explanationZh: '理型世界不在任何物理位置，也不是人类大脑的发明。柏拉图认为理型是客观的、永恒的、不依赖任何人的认知而存在的实在。第二个选项是后来经验主义者的立场，第四个选项更接近后来基督教神学对理型论的改造。',
      explanationEn: 'TODO',
    ),

    QuizQuestion(
      questionZh: '有人说"美就是主观感受，每个人标准不同"。柏拉图最可能怎么回应？',
      questionEn: 'TODO',
      options: [
        QuizOption(textZh: '同意，美确实因人而异，这恰恰说明现实世界的不完美', textEn: 'TODO'),
        QuizOption(textZh: '不同意，如果美纯粹主观，就无法解释为什么跨文化跨时代人类对美有大量共识', textEn: 'TODO'),
        QuizOption(textZh: '不同意，美的标准是由社会共同决定的，不是个人的主观感受', textEn: 'TODO'),
        QuizOption(textZh: '同意，但正因为每个人的感受不同，所以我们更需要通过理性去追寻"美本身"', textEn: 'TODO'),
      ],
      correctIndex: 1,
      explanationZh: '柏拉图会用人类对美的广泛共识来论证"美本身"独立于个人感受而存在。第四个选项前半句同意了"美是主观的"，这与柏拉图的立场矛盾。第三个选项把标准归于社会约定，柏拉图认为标准来自理型世界，不是社会产物。',
      explanationEn: 'TODO',
    ),
  ],
);

/// ╔══════════════════════════════════════════════════════════════════╗
/// ║                   对话树设计指南                                 ║
/// ╠══════════════════════════════════════════════════════════════════╣
/// ║                                                                ║
/// ║  两种节点：                                                     ║
/// ║  • 有选项 → choices: [...]（学生选择后跳转）                     ║
/// ║  • 无选项 → nextNodeId: 'xxx'（学生轻触继续）                    ║
/// ║  • 结束   → isEndNode: true                                    ║
/// ║                                                                ║
/// ║  speaker：'philosopher' 或 'narrator'                           ║
/// ║                                                                ║
/// ╠══════════════════════════════════════════════════════════════════╣
/// ║                                                                ║
/// ║  常见结构：                                                     ║
/// ║                                                                ║
/// ║  1. 菱形（分叉→收拢→再分叉→收拢）                               ║
/// ║                                                                ║
/// ║         n1                                                     ║
/// ║        /|\                                                     ║
/// ║     n2a n2b n2c                                                ║
/// ║        \|/                                                     ║
/// ║         n3                                                     ║
/// ║        / \                                                     ║
/// ║     n4a   n4b                                                  ║
/// ║        \ /                                                     ║
/// ║         n5 (end)                                               ║
/// ║                                                                ║
/// ║  2. 线性（全用 nextNodeId）                                     ║
/// ║                                                                ║
/// ║     n1 → n2 → n3 → n4 (end)                                   ║
/// ║                                                                ║
/// ║  3. 混合                                                       ║
/// ║                                                                ║
/// ║     n1 → n2 → n3 (提问)                                       ║
/// ║                / \                                              ║
/// ║             n4a   n4b                                          ║
/// ║                \ /                                              ║
/// ║                 n5 (end)                                       ║
/// ║                                                                ║
/// ║  4. 深度分叉                                                    ║
/// ║                                                                ║
/// ║           n1                                                   ║
/// ║          / \                                                   ║
/// ║       n2a   n2b                                                ║
/// ║       / \     |                                                ║
/// ║    n3a  n3b  n3c                                               ║
/// ║       \ | /                                                    ║
/// ║         n4 → n5 (end)                                          ║
/// ║                                                                ║
/// ╠══════════════════════════════════════════════════════════════════╣
/// ║  注意：                                                         ║
/// ║  • 所有分支最终必须能到达 isEndNode                              ║
/// ║  • 建议总节点 5-10 个                                           ║
/// ║  • 选项文字简短（1-2句），对话正文可以长                           ║
/// ╚══════════════════════════════════════════════════════════════════╝
