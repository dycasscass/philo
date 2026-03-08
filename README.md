# PhiloQuest - 哲学探索之旅

一款交互式哲学学习应用，通过游戏化的方式带你穿越哲学史，从古希腊到当代哲学。

## 项目简介

PhiloQuest 将复杂的哲学概念变成互动体验。每节课采用五步学习法，让用户在沉浸式的叙事中理解哲学思想：

1. **思想实验** - 用假设场景引入哲学问题
2. **核心教学** - 带有历史背景的哲学概念讲解
3. **对话互动** - 与哲学家的交互式问答
4. **深度反思** - 个人思考与写作
5. **知识测验** - 学习成果检验

## 主要功能

### 世界地图导航
- 手绘风格世界地图，展示 11 个哲学时代
- 支持平移/缩放，响应式布局适配各种屏幕
- 课程顺序解锁机制（完成当前课程才能解锁下一课）
- 支持 `?unlock=all` URL 参数跳过锁定（开发调试用）

### 课程内容
目前已完成**古希腊哲学**世界的 3 节课程：
- 柏拉图的洞穴寓言 - 认识论与现实的本质
- 柏拉图的理型论 - 抽象与具象的探索
- 柏拉图的理想国 - 正义与治理

规划中的哲学世界：
- 中世纪哲学、理性主义、经验主义、功利主义
- 德国唯心主义、生命哲学、现象学
- 存在主义、分析哲学、当代哲学

### 游戏化系统
- 经验值 (XP) 追踪与等级晋升
- 每日连续学习天数统计
- 课程完成进度追踪
- 世界/章节完成标记

### 双语支持
- 完整的中文（简体）和英文界面
- 个人资料页语言切换
- 语言偏好本地持久化

### 沉浸式体验
- 打字机动画文字展示
- 脉冲发光动效标示当前进度
- 渐入动画列表展示
- 深色经典主题，沉稳的哲学氛围

## 技术架构

### 技术栈
- **框架:** Flutter (SDK ^3.6.2)
- **语言:** Dart
- **平台:** iOS / Android / Web
- **数据存储:** SharedPreferences（本地存储，无云端后端）
- **部署:** Netlify (Web) + GitHub Actions CI/CD

### 项目结构

```
lib/
├── main.dart                          # 应用入口，底部导航栏
├── models/
│   ├── lesson.dart                    # 课程数据模型（五步结构）
│   └── world.dart                     # 哲学世界/时代配置
├── screens/
│   ├── course_map_screen.dart         # 交互式世界地图
│   ├── philosopher_collection_screen.dart  # 哲学家图鉴（开发中）
│   ├── notebook_screen.dart           # 笔记本（开发中）
│   ├── profile_screen.dart            # 个人资料与设置
│   └── lesson/
│       ├── lesson_screen.dart         # 课程主控制器（五步流程）
│       ├── thought_experiment_step.dart
│       ├── teaching_step.dart
│       ├── dialogue_step.dart
│       ├── reflection_step.dart
│       └── quiz_step.dart
├── services/
│   └── storage_service.dart           # 本地数据持久化
├── theme/
│   └── app_theme.dart                 # 深色经典主题配色
├── l10n/
│   └── app_localizations.dart         # 中英双语本地化
├── widgets/
│   ├── typewriter_controller.dart     # 打字机动画控制器
│   ├── thinking_indicator.dart        # 思考中指示器（三点脉冲）
│   └── staggered_fade_in.dart         # 列表渐入动画
└── data/
    └── worlds/
        └── ancient_greece/            # 古希腊哲学课程数据
            ├── plato_lesson1_cave.dart
            ├── plato_lesson2_forms.dart
            └── plato_lesson3_republic.dart
```

### 设计主题

| 元素 | 色值 | 说明 |
|------|------|------|
| 主色调 | `#1A1F2E` | 深邃蓝黑 |
| 强调色 | `#D4A574` | 古典琥珀金 |
| 背景色 | `#0F1219` | 极深背景 |
| 成功色 | `#6B8F71` | 橄榄绿 |
| 错误色 | `#C4616C` | 赤陶红 |

## 快速开始

### 环境要求
- Flutter SDK ^3.6.2
- Dart SDK

### 安装与运行

```bash
# 克隆项目
git clone <repo-url>
cd philo

# 安装依赖
flutter pub get

# 运行（Web）
flutter run -d chrome

# 运行（iOS）
flutter run -d ios

# 构建 Web 版本
./build.sh
```

### 部署

项目已配置 Netlify 自动部署和 GitHub Actions CI/CD 工作流，推送到主分支即可自动构建部署 Web 版本。

## 待开发功能

- [ ] 更多哲学世界的课程内容（亚里士多德、斯多葛派、伊壁鸠鲁等）
- [ ] 哲学家图鉴 - 解锁并浏览哲学家详细资料
- [ ] 笔记本 - 保存反思笔记与学习记录
- [ ] 成就/徽章系统
