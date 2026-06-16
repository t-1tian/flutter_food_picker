import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppFoodCard extends StatefulWidget {
  const AppFoodCard({
    required this.foodName,
    this.description,
    this.spicy,
    this.cuisine,
    this.ingredients,
    this.isPlaceholder = false,
    this.animateEntry = true,
    super.key,
  });

  final String foodName;
  final String? description;
  final String? spicy;
  final String? cuisine;
  final String? ingredients;
  final bool isPlaceholder;
  final bool animateEntry;

  @override
  State<AppFoodCard> createState() => _AppFoodCardState();
}

class _AppFoodCardState extends State<AppFoodCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );
    _scaleController.forward();
  }

  @override
  void didUpdateWidget(covariant AppFoodCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.foodName != widget.foodName && widget.animateEntry) {
      _scaleController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(_scaleAnimation),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xl,
        ),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: AppColors.surfaceWarm,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.restaurant_menu_rounded,
                color: AppColors.primaryDark,
                size: 38,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // 渐变色菜名
            FittedBox(
              fit: BoxFit.scaleDown,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Text(
                  widget.foodName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.foodName.copyWith(
                    color: Colors.white, // ShaderMask 需要，实际显示渐变
                  ),
                ),
              ),
            ),
            // 描述
            if (widget.description != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.description!,
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
            ],
            // 辣度 + 菜系 + 食材（非占位时显示）
            if (!widget.isPlaceholder) ...[
              const SizedBox(height: AppSpacing.md),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: [
                  _InfoChip(
                    label: widget.spicy ?? '',
                    color: _spicyColor(widget.spicy),
                  ),
                  if (widget.cuisine != null)
                    _InfoChip(
                      label: widget.cuisine!,
                      color: AppColors.mint,
                    ),
                ],
              ),
              if (widget.ingredients != null &&
                  widget.ingredients!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  widget.ingredients!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(fontSize: 13),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Color _spicyColor(String? spicy) {
    switch (spicy) {
      case '特辣':
        return Colors.red;
      case '辣':
        return Colors.deepOrange;
      case '中等':
        return AppColors.primary;
      case '微辣':
        return AppColors.accent;
      default:
        return AppColors.mint;
    }
  }
}

/// 辣度/菜系小标签
class _InfoChip extends StatefulWidget {
  const _InfoChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  State<_InfoChip> createState() => _InfoChipState();
}

class _InfoChipState extends State<_InfoChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;
  late final Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _bounceAnimation = CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    );
    _bounceController.forward();
  }

  @override
  void didUpdateWidget(covariant _InfoChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.label != widget.label) {
      _bounceController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(_bounceAnimation),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: widget.color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
