import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String projectName = '今天吃啥';
  static const String version = 'v1.0.0';
  static const String teamName = '第三组';

  static const List<_Member> members = [
    _Member(name: '蒋亿乐', studentId: '20241060087', role: '组长'),
    _Member(name: '于昕冉', studentId: '20211170108'),
    _Member(name: '张蕴洁', studentId: '20241060249'),
    _Member(name: '刘昱泽', studentId: '20241120066'),
    _Member(name: '杨晨曦', studentId: '20241120237'),
    _Member(name: '王小梅', studentId: '20241060347'),
    _Member(name: '唐一甜', studentId: '20241120103'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isNarrow = constraints.maxWidth < 380;
        final double horizontalPadding = isNarrow
            ? AppSpacing.pageHorizontalCompact
            : AppSpacing.pageHorizontalWide;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                AppSpacing.lg,
                horizontalPadding,
                AppSpacing.xl,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppSpacing.maxContentWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _PageHeader(),
                      const SizedBox(height: AppSpacing.lg),
                      _ProjectCard(),
                      const SizedBox(height: AppSpacing.md),
                      _TeamCard(),
                      const SizedBox(height: AppSpacing.md),
                      _DevNotesCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ---------- Private widgets ----------

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.surfaceWarm,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: const Icon(
            Icons.info_outline_rounded,
            color: AppColors.primaryDark,
            size: 28,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('关于我们', style: AppTextStyles.pageTitle),
              SizedBox(height: AppSpacing.xxs),
              Text('了解更多', style: AppTextStyles.subtitle),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: '项目信息',
      icon: Icons.apps_rounded,
      children: [
        _buildRow('项目名称', AboutPage.projectName),
        const _Divider(),
        _buildRow('版本', AboutPage.version),
        const _Divider(),
        _buildRow('开发框架', 'Flutter (Material 3)'),
        const _Divider(),
        _buildRow('支持平台', 'Android / Web'),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: AppTextStyles.body),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: '团队介绍',
      icon: Icons.people_rounded,
      subtitle: AboutPage.teamName,
      children: [
        const SizedBox(height: AppSpacing.sm),
        ...AboutPage.members.asMap().entries.map((entry) {
          final member = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              bottom: entry.key < AboutPage.members.length - 1
                  ? AppSpacing.sm
                  : 0,
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWarm,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    member.name[0],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            member.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                              height: 1.3,
                            ),
                          ),
                          if (member.role != null) ...[
                            const SizedBox(width: AppSpacing.xs),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                member.role!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        member.studentId,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _DevNotesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: '开发说明',
      icon: Icons.code_rounded,
      children: const [
        SizedBox(height: AppSpacing.sm),
        Text(
          '本项目为移动应用软件开发实训期末大作业，由第三组协作完成。'
          '应用旨在帮助用户解决"今天吃什么"的选择困难问题，'
          '通过随机抽取菜品提供趣味性决策辅助。',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          '所有餐饮数据均为公开测试数据，本应用不收集任何用户隐私信息，'
          '不获取地理位置权限，符合相关网络安全规范。',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

// ---------- Reusable card shell ----------

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.children,
    this.subtitle,
  });

  final String title;
  final IconData icon;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surfaceWarm,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(icon, size: 20, color: AppColors.primaryDark),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: AppTextStyles.body,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...children,
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.border,
      ),
    );
  }
}

// ---------- Data model ----------

class _Member {
  const _Member({
    required this.name,
    required this.studentId,
    this.role,
  });

  final String name;
  final String studentId;
  final String? role;
}
