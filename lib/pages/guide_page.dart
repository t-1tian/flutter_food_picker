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
        padding: const EdgeInsets.all(20),
        children: [
          // 标题区域
          Card(
            color: colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.menu_book, size: 48, color: colorScheme.onPrimaryContainer),
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
                    '只需三步，帮你告别选择困难',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                        ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 步骤一
          _StepCard(
            step: '1',
            title: '打开应用',
            description: '启动「今天吃啥」应用，进入首页。首页会展示随机菜品推荐区域和功能按钮。',
            icon: Icons.open_in_browser,
          ),
          const SizedBox(height: 16),

          // 步骤二
          _StepCard(
            step: '2',
            title: '点击随机按钮',
            description: '点击首页的「随机抽取」按钮，系统会从 50+ 道菜品中随机为你挑选一道，显示在屏幕上。如果对结果不满意，可以再次点击按钮重新抽取。',
            icon: Icons.touch_app,
          ),
          const SizedBox(height: 16),

          // 步骤三
          _StepCard(
            step: '3',
            title: '查看结果',
            description: '随机结果会以卡片形式展示，包含菜品名称。你可以根据推荐结果决定今天的用餐选择。',
            icon: Icons.visibility,
          ),
          const SizedBox(height: 24),

          // 使用场景
          Text(
            '使用场景',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          _ScenarioCard(
            title: '午餐/晚餐选择困难',
            description: '打工人和学生的日常痛点——不知道中午吃啥、晚上吃啥。打开应用随手一点，让系统帮你做决定。',
            icon: Icons.lunch_dining,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 12),

          _ScenarioCard(
            title: '朋友聚会点菜',
            description: '和朋友们一起用，每人点一次，随机结果增加趣味性，还能减少"随便"带来的争执。',
            icon: Icons.group,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 12),

          _ScenarioCard(
            title: '尝试新口味',
            description: '菜品库包含多种菜系，随机抽取能帮你跳出日常饮食习惯，尝试平时很少点的菜。',
            icon: Icons.explore,
            colorScheme: colorScheme,
          ),

          const SizedBox(height: 40),

          // 页脚
          Center(
            child: Text(
              '— 祝你好胃口 —',
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

/// 步骤卡片
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              child: Text(step, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 20, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

/// 场景卡片
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
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: colorScheme.secondary, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.4,
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
