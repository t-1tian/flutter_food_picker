# Member A Delivery - Home UI and Shared Styles

## 1. What Member A implemented

- Initialized a clean Flutter app named `today_eat_app` because the remote repository was empty.
- Added the Material 3 app entry, theme setup, and home page layout.
- Built the home screen UI for `今日吃啥 / What to Eat Today` with:
  - title `今日吃啥`
  - subtitle `选择困难症救星`
  - central food display card showing `宫保鸡丁`
  - description `酸甜咸香 · 下饭经典`
  - hint text `点击按钮，随机决定今天吃什么`
  - main button `开始随机`
  - bottom navigation labels `首页 / 说明 / 合规 / 关于`
- Added reusable style and widget files for other members:
  - shared colors
  - shared text styles
  - shared spacing and radius constants
  - shared Material theme
  - reusable primary button
  - reusable food display card
  - reusable bottom navigation
- Made the home layout responsive with `SafeArea`, `LayoutBuilder`, max content width, compact padding, `SingleChildScrollView`, and text scaling protection for the food name.

## 2. Files added or modified

- `pubspec.yaml`
- `analysis_options.yaml`
- `.gitignore`
- `.metadata`
- `README.md`
- `web/index.html`
- `web/manifest.json`
- `lib/main.dart`
- `lib/app.dart`
- `lib/theme/app_colors.dart`
- `lib/theme/app_text_styles.dart`
- `lib/theme/app_spacing.dart`
- `lib/theme/app_theme.dart`
- `lib/widgets/app_primary_button.dart`
- `lib/widgets/app_food_card.dart`
- `lib/widgets/app_bottom_nav.dart`
- `lib/pages/home_page.dart`
- `docs/member_a/README_A.md`

## 3. Intentionally left for other members

- Member B: random food selection logic is not implemented. `HomePage.onRandomPressed` is the extension point.
- Member C: no HTTP request, JSON parsing, or `food_list.json` was added.
- Member D: About Us page content is not implemented.
- Member E: tutorial page and privacy/compliance page content are not implemented.
- Member F: repository management and real-device testing are not implemented by Member A.

## 4. How to run

```bash
flutter pub get
flutter run
```

For Chrome:

```bash
flutter run -d chrome
```

## 5. Screenshot instructions

No final screenshot image is committed because the in-app browser in this environment could not access the temporary local preview server, and the Flutter golden-test screenshot route produced unreliable Chinese font rendering / timeout behavior. No fake screenshot was created.

To capture the required screenshot locally:

1. Run `flutter pub get`.
2. Run `flutter run -d chrome`.
3. Open the home screen.
4. Use Chrome DevTools device toolbar with a mobile size such as `390 x 844`.
5. Capture the viewport screenshot.
6. Save it as `docs/member_a/screenshots/home_page.png`.

## 6. Testing result

Commands run:

```bash
flutter pub get
flutter analyze
flutter build web
```

`flutter analyze` result:

```text
Analyzing group3_qimozuoye...
No issues found! (ran in 39.7s)
```

`flutter build web` completed successfully and generated `build/web`, which is ignored by git.

## PR summary

Title:

```text
[A] Home UI and Shared Style System
```

Description:

```markdown
## Completed Member A UI tasks
- Added Material 3 Flutter app shell for 今天吃啥.
- Implemented responsive home page layout with title, subtitle, food card, hint text, main action button, and bottom navigation visual layout.
- Added reusable shared style system and UI widgets for other members.

## Main files changed
- lib/app.dart
- lib/pages/home_page.dart
- lib/theme/app_colors.dart
- lib/theme/app_text_styles.dart
- lib/theme/app_spacing.dart
- lib/theme/app_theme.dart
- lib/widgets/app_primary_button.dart
- lib/widgets/app_food_card.dart
- lib/widgets/app_bottom_nav.dart
- docs/member_a/README_A.md

## Testing performed
- flutter pub get
- flutter analyze
- flutter build web

## Notes for B/C/D/E/F integration
- Member B can pass the selected food name into HomePage.displayedFoodName and connect HomePage.onRandomPressed.
- Member C can add data loading later; no JSON or network code is included in this PR.
- Members D/E can connect bottom navigation items to their pages later.
- Member F can run final repository and real-device verification.
```
