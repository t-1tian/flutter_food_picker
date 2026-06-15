# 八、项目结构（参考）

# 目录约定
lib/
├── main.dart                  # 入口
├── pages/
│   ├── home_page.dart         # 首页（随机按钮 + 菜品展示）
│   ├── about_page.dart        # 关于我们（D 同学负责）
│   ├── guide_page.dart        # 使用说明（E 同学负责）
│   └── privacy_page.dart      # 隐私合规（E 同学负责）
├── widgets/                   # 通用组件（A 同学负责）
│   ├── app_button.dart        # 统一按钮样式
│   ├── app_text.dart          # 统一文本样式
│   └── app_card.dart          # 统一卡片样式
├── services/                  # 服务层（C 同学负责）
│   ├── api_service.dart       # 网络请求
│   └── food_repository.dart   # JSON 解析 + 数据封装
└── theme/
    └── app_theme.dart         # 全局主题

assets/
└── food_list.json             # 菜品数据（50+ 道，C 同学负责）

web/                           # Flutter Web 构建目录（自动生成）
screenshots/                   # 截图（所有人）
