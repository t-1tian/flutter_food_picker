import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('使用说明'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        children: [
          // ── 顶部标题卡片 ──────────────────────────────
          Card(
            color: colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.menu_book_rounded, size: 52,
                      color: colorScheme.onPrimaryContainer),
                  const SizedBox(height: 12),
                  Text(
                    '今天吃啥 · 使用教程',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '只需三步，帮你告别选择困难症',
                    style: TextStyle(
                      color: colorScheme.onPrimaryContainer.withValues(alpha: 0.75),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ── 简介段落 ────────────────────────────────
          Text(
            '软件简介',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '「今天吃啥」是一款轻量级随机菜品决策小工具。'
            '每天纠结吃什么？只需打开 App，点击随机按钮，'
            '系统即从 50 余道菜品中为你随机抽取一道，快速终结选择困难。'
            '全程本地运行，无需注册，无需登录，打开即用。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.7,
                ),
          ),

          const SizedBox(height: 24),

          // ── 操作步骤标题 ────────────────────────────
          Text(
            '操作步骤',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          // 步骤一
          _StepCard(
            step: '1',
            title: '打开应用，进入首页',
            description: '启动「今天吃啥」，即可看到首页。'
                '首页中央展示随机菜品结果区域，下方有「随机一道菜」功能按钮，'
                '右上角或底部导航可跳转至本页面（使用说明）和隐私合规页。',
            icon: Icons.smartphone,
          ),
          const SizedBox(height: 12),

          // 步骤二
          _StepCard(
            step: '2',
            title: '点击「随机一道菜」按钮',
            description: '点击首页的随机按钮，系统会立刻从菜品库中随机抽出一道菜'
                '并显示在屏幕中央。如果对本次结果不满意，'
                '再次点击按钮即可重新抽取，直到满意为止。',
            icon: Icons.touch_app_rounded,
          ),
          const SizedBox(height: 12),

          // 步骤三
          _StepCard(
            step: '3',
            title: '查看随机结果，开始用餐',
            description: '随机结果以卡片形式展示菜品名称。'
                '根据推荐结果决定今天的餐食，或者把结果分享给朋友，'
                '告别每天的「吃什么」世纪难题。',
            icon: Icons.restaurant_rounded,
          ),

          const SizedBox(height: 28),

          // ── 适用场景标题 ────────────────────────────
          Text(
            '适用场景',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '以下场景都很适合打开「今天吃啥」来帮你做决定：',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 12),

          _ScenarioCard(
            title: '午餐 / 晚餐选不出来',
            description: '打工人和学生的经典痛点——盯着手机不知道点什么。'
                '打开 App，一键随机，三秒搞定今天的用餐选择。',
            icon: Icons.lunch_dining_rounded,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 10),

          _ScenarioCard(
            title: '朋友聚会点菜僵局',
            description: '一群人聚在一起，你说随便我说随便，然后谁都不动。'
                '让 App 帮大家做决定，公平又有趣，还能顺带涨见识。',
            icon: Icons.groups_rounded,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 10),

          _ScenarioCard(
            title: '想换口味但没灵感',
            description: '菜品库涵盖多种菜系，随机结果能帮你跳出日常的外卖循环，'
                '发现平时很少点但其实很好吃的菜。',
            icon: Icons.explore_rounded,
            colorScheme: colorScheme,
          ),

          const SizedBox(height: 28),

          // ── 常见问题 ────────────────────────────────
          Text(
            '常见问题',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          _FaqItem(
            question: '菜品数据从哪里来？',
            answer: '菜品数据由项目组整理，包含 50 余道常见中式菜名，'
                '以 JSON 格式存储，每次启动时从网络加载最新数据。',
          ),
          const SizedBox(height: 10),

          _FaqItem(
            question: '需要登录或注册吗？',
            answer: '不需要。本应用无账号系统，打开即可使用，'
                '不采集任何用户身份信息。',
          ),
          const SizedBox(height: 10),

          _FaqItem(
            question: '没有网络能用吗？',
            answer: '首次使用需要网络加载菜品数据。'
                '若网络异常，应用会显示错误提示，建议检查网络后重试。',
          ),

          const SizedBox(height: 40),

          // ── 页脚 ────────────────────────────────────
          Center(
            child: Text(
              '— 祝你每天都有好胃口 🍜 —',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ── 步骤卡片 ──────────────────────────────────────────
class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.step,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String step;
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              child: Text(step,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 18, color: colorScheme.primary),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.6,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 场景卡片 ──────────────────────────────────────────
class _ScenarioCard extends StatelessWidget {
  const _ScenarioCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.colorScheme,
  });

  final String title;
  final String description;
  final IconData icon;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colorScheme.secondary, size: 26),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 常见问题条目 ──────────────────────────────────────
class _FaqItem extends StatelessWidget {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Q  ',
                    style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                Expanded(
                  child: Text(question,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('A  ',
                    style: TextStyle(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                Expanded(
                  child: Text(
                    answer,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.6,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
