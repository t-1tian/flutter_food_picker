import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    final ColorScheme scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primary,
          secondary: AppColors.mint,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamilyFallback: const [
        'Noto Sans SC',
        'Microsoft YaHei',
        'Noto Sans CJK SC',
        'PingFang SC',
        'Heiti SC',
        'SimHei',
      ],
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.pageTitle,
        titleMedium: AppTextStyles.subtitle,
        bodyMedium: AppTextStyles.body,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.surfaceWarm,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          final Color color = states.contains(WidgetState.selected)
              ? AppColors.primaryDark
              : AppColors.textSecondary;
          return AppTextStyles.navLabel.copyWith(color: color);
        }),
      ),
    );
  }
}
