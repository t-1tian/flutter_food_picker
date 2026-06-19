import 'dart:math';

import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'about_page.dart';
import 'guide_page.dart';
import 'privacy_page.dart';
import '../services/food_repository.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_food_card.dart';
import '../widgets/app_primary_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  int _currentNavIndex = 0;

  // 数据状态
  List<Food> _foods = [];
  Food? _currentFood;
  LoadStatus _status = LoadStatus.idle;
  String? _errorMessage;

  // 老虎机滚动状态
  bool _isRolling = false;

  // 标题呼吸脉动动画
  late final AnimationController _breathController;
  late final Animation<double> _breathAnimation;

  @override
  void initState() {
    super.initState();
    // 标题呼吸脉动
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _breathAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );
    _loadFoods();
  }

  @override
  void dispose() {
    _breathController.dispose();
    super.dispose();
  }

  Future<void> _loadFoods() async {
    setState(() {
      _status = LoadStatus.loading;
      _errorMessage = null;
    });

    final result = await FoodRepository.instance.fetchAllFoods();

    if (!mounted) return;

    if (result.isSuccess) {
      setState(() {
        _foods = result.data!;
        _status = LoadStatus.success;
      });
    } else if (result.isEmpty) {
      setState(() {
        _status = LoadStatus.empty;
        _errorMessage = result.message;
      });
    } else {
      setState(() {
        _status = LoadStatus.error;
        _errorMessage = result.message ?? '加载失败';
      });
    }
  }

  void _handleRandomPressed() {
    if (_foods.isEmpty || _isRolling) return;

    final random = Random();

    // 先确定最终结果（避免连续同一道）
    Food finalFood;
    do {
      finalFood = _foods[random.nextInt(_foods.length)];
    } while (_foods.length > 1 && _currentFood != null && finalFood.id == _currentFood!.id);

    setState(() => _isRolling = true);

    // 老虎机滚动：间隔从短到长，逐渐减速
    _rollSlot(finalFood);
  }

  void _rollSlot(Food finalFood) {
    // 滚动节奏：快速→中速→慢速→停止
    const List<int> intervals = [
      60, 60, 60, 60, 60,   // 5次快速
      100, 100, 100, 100,   // 4次中速
      180, 180, 180,        // 3次中慢
      300, 300,             // 2次慢
      500,                  // 1次很慢
    ];

    int step = 0;

    void tick() {
      if (!mounted) return;

      if (step < intervals.length) {
        // 滚动中：随机选一道显示
        final randomFood = _foods[Random().nextInt(_foods.length)];
        setState(() {
          _currentFood = randomFood;
        });
        step++;
        Future.delayed(Duration(milliseconds: intervals[step - 1]), tick);
      } else {
        // 停下：显示最终结果
        setState(() {
          _currentFood = finalFood;
          _isRolling = false;
        });
      }
    }

    tick();
  }

  void _handleNavSelected(int index) {
    setState(() => _currentNavIndex = index);
    // TODO(Members D/E): Wire these visual nav items to real pages later.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentNavIndex,
        children: [
          // 首页 - B同学实现的随机选菜功能
          _HomeTabContent(
            status: _status,
            errorMessage: _errorMessage,
            foods: _foods,
            currentFood: _currentFood,
            isRolling: _isRolling,
            breathAnimation: _breathAnimation,
            onRandomPressed: _handleRandomPressed,
            onRetry: _loadFoods,
          ),
          const GuidePage(),
          const PrivacyPage(),
          const AboutPage(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentNavIndex,
        onItemSelected: _handleNavSelected,
      ),
    );
  }
}

// ============================================================
// 首页 Tab 内容（B同学：随机选菜核心功能 + 交互动效）
// ============================================================

class _HomeTabContent extends StatelessWidget {
  const _HomeTabContent({
    required this.status,
    required this.errorMessage,
    required this.foods,
    required this.currentFood,
    required this.isRolling,
    required this.breathAnimation,
    required this.onRandomPressed,
    required this.onRetry,
  });

  final LoadStatus status;
  final String? errorMessage;
  final List<Food> foods;
  final Food? currentFood;
  final bool isRolling;
  final Animation<double> breathAnimation;
  final VoidCallback onRandomPressed;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        _BreathHeader(animation: breathAnimation),
                        SizedBox(height: isNarrow ? AppSpacing.lg : 44),
                        _buildBody(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (status) {
      case LoadStatus.loading:
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        );
      case LoadStatus.error:
        return _buildError();
      case LoadStatus.empty:
        return _buildEmpty();
      default:
        return _buildContent();
    }
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.primaryDark,
              size: 48,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              errorMessage ?? '加载失败',
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: 160,
              child: AppPrimaryButton(
                text: '重试',
                icon: Icons.refresh_rounded,
                onPressed: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.no_meals_outlined,
              color: AppColors.textSecondary,
              size: 48,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              errorMessage ?? '暂无菜品数据',
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final bool hasSelection = currentFood != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSwitcher(
          duration: isRolling
              ? const Duration(milliseconds: 50)
              : const Duration(milliseconds: 400),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (Widget child, Animation<double> animation) {
            if (isRolling) {
              // 滚动时只做 fade，不做 slide
              return FadeTransition(opacity: animation, child: child);
            }
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.15),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: hasSelection
              ? AppFoodCard(
                  key: ValueKey(currentFood!.id),
                  foodName: currentFood!.name,
                  description: '${currentFood!.cuisine} · ${currentFood!.spicy}',
                  spicy: currentFood!.spicy,
                  cuisine: currentFood!.cuisine,
                  ingredients: currentFood!.ingredientsText,
                  animateEntry: !isRolling,
                )
              : const AppFoodCard(
                  foodName: '今天吃什么',
                  isPlaceholder: true,
                ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _HintText(),
        const SizedBox(height: AppSpacing.lg),
        AppPrimaryButton(
          text: '开始随机',
          onPressed: foods.isNotEmpty && !isRolling ? onRandomPressed : null,
        ),
      ],
    );
  }
}

/// 带呼吸动画的标题
class _BreathHeader extends StatelessWidget {
  const _BreathHeader({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: Row(
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
      ),
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

// ---------- Placeholder page for E's work ----------

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surfaceWarm,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, size: 36, color: AppColors.primaryDark),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
