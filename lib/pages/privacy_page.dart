import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('隐私合规'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 标题区域
          Card(
            color: colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.shield, size: 48, color: colorScheme.onSecondaryContainer),
                  const SizedBox(height: 12),
                  Text(
                    '隐私合规声明',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSecondaryContainer,
                        ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 声明一：不收集用户隐私
          _PrivacyItem(
            icon: Icons.privacy_tip_outlined,
            title: '不收集用户隐私',
            content: '本应用是一款本地随机菜品推荐工具，'
                '不会收集、存储或上传用户的任何个人信息，'
                '包括但不限于姓名、手机号、邮箱地址、通讯录、相册等敏感数据。'
                '应用运行过程中产生的随机结果仅在本地设备显示，不会发送至任何远程服务器。',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 16),

          // 声明二：不获取地理位置
          _PrivacyItem(
            icon: Icons.location_off,
            title: '不获取地理位置',
            content: '本应用不会请求、收集或使用设备的 GPS 定位、'
                '基站定位、Wi-Fi 定位等任何形式的地理位置信息。'
                '应用无需知晓用户所在位置即可正常使用全部功能。',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 16),

          // 声明三：餐饮数据说明
          _PrivacyItem(
            icon: Icons.fastfood,
            title: '餐饮数据说明',
            content: '本应用中展示的所有餐饮数据（菜品名称、分类等）均为公开测试数据，'
                '由项目组自行整理编辑。数据来源于通用菜名和常识性分类，'
                '不涉及任何真实餐厅、商户或用户的真实订餐记录。'
                '所有菜品数据以 JSON 格式托管于 Gitee 公开仓库，仅供学习与测试使用。',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 16),

          // 声明四：合规说明
          _PrivacyItem(
            icon: Icons.verified_user,
            title: '网络安全与隐私规范',
            content: '本应用遵循《中华人民共和国网络安全法》《中华人民共和国个人信息保护法》'
                '及《App 违法违规收集使用个人信息行为认定方法》等相关法律法规。'
                '应用在设计和实现过程中始终坚持最小权限原则，'
                '仅使用 Flutter 框架运行所需的基础权限，不额外申请网络访问之外的系统权限。',
            colorScheme: colorScheme,
          ),

          const SizedBox(height: 32),

          // 底部提示
          Card(
            color: colorScheme.tertiaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: colorScheme.onTertiaryContainer),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '本应用为移动应用软件开发实训课程项目，仅供教学演示。'
                      '如您对本应用的隐私保护有任何疑问，请联系课程教师或项目组长。',
                      style: TextStyle(
                        color: colorScheme.onTertiaryContainer,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          Center(
            child: Text(
              '项目名称：今天吃啥（Random Food Picker）\n'
              '版本：v1.0.0\n'
              '更新日期：2026 年 6 月',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

/// 隐私声明条目
class _PrivacyItem extends StatelessWidget {
  const _PrivacyItem({
    required this.icon,
    required this.title,
    required this.content,
    required this.colorScheme,
  });

  final IconData icon;
  final String title;
  final String content;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.secondary, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
