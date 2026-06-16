import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_food_card.dart';
import '../widgets/app_primary_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.displayedFoodName,
    required this.foodDescription,
    super.key,
    this.onRandomPressed,
  });

  final String displayedFoodName;
  final String foodDescription;
  final VoidCallback? onRandomPressed;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
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
                    AppSpacing.lg,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: AppSpacing.maxContentWidth,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _Header(),
                          SizedBox(height: isNarrow ? AppSpacing.lg : 44),
                          AppFoodCard(
                            foodName: widget.displayedFoodName,
                            description: widget.foodDescription,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          const _HintText(),
                          const SizedBox(height: AppSpacing.lg),
                          AppPrimaryButton(
                            text: '开始随机',
                            onPressed:
                                widget.onRandomPressed ?? _handleRandomPressed,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentNavIndex,
        onItemSelected: _handleNavSelected,
      ),
    );
  }

  void _handleRandomPressed() {
    // TODO(Member B): Connect this callback to random food selection logic.
  }

  void _handleNavSelected(int index) {
    setState(() => _currentNavIndex = index);
    // TODO(Members D/E): Wire these visual nav items to real pages later.
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: const Icon(
            Icons.lunch_dining_rounded,
            color: AppColors.textPrimary,
            size: 28,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('今日吃啥', style: AppTextStyles.pageTitle),
              SizedBox(height: AppSpacing.xxs),
              Text('选择困难症救星', style: AppTextStyles.subtitle),
            ],
          ),
        ),
      ],
    );
  }
}

class _HintText extends StatelessWidget {
  const _HintText();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.tips_and_updates_outlined,
          color: AppColors.primaryDark,
          size: 18,
        ),
        SizedBox(width: AppSpacing.xs),
        Expanded(child: Text('点击按钮，随机决定今天吃什么', style: AppTextStyles.body)),
      ],
    );
  }
}
