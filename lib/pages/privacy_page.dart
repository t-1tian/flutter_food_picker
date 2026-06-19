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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        children: [
          // ── 顶部标题卡片 ──────────────────────────────
          Card(
            color: colorScheme.secondaryContainer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.shield_rounded, size: 52,
                      color: colorScheme.onSecondaryContainer),
                  const SizedBox(height: 12),
                  Text(
                    '隐私合规声明',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSecondaryContainer,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '今天吃啥 · Random Food Picker',
                    style: TextStyle(
                      color: colorScheme.onSecondaryContainer.withValues(alpha: 0.75),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── 前言段落 ────────────────────────────────
          Text(
            '前言',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '「今天吃啥」是一款服务于移动应用软件开发实训课程的演示项目。'
            '本声明旨在向用户清楚说明本应用对数据和权限的使用方式，'
            '保障用户的知情权与隐私权。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.7,
                ),
          ),

          const SizedBox(height: 24),

          // ── 声明一：不收集用户隐私 ───────────────────
          _SectionTitle(title: '一、不收集用户隐私'),
          const SizedBox(height: 10),
          _PrivacyItem(
            icon: Icons.privacy_tip_outlined,
            title: '本应用不收集任何个人信息',
            content: '本应用是一款本地随机菜品推荐工具，完全不会收集、存储或上传用户的任何个人信息。\n\n'
                '以下信息均不会被获取：\n'
                '• 姓名、昵称、手机号码、电子邮箱\n'
                '• 通讯录、通话记录、短信内容\n'
                '• 相册、本地文件、剪贴板内容\n'
                '• 设备唯一标识符（IMEI、MAC 地址等）\n'
                '• 浏览记录、应用使用习惯\n\n'
                '应用运行过程中产生的随机结果仅在当前设备的屏幕上显示，'
                '不会发送至任何远程服务器，也不会被记录或留存。',
            colorScheme: colorScheme,
          ),

          const SizedBox(height: 16),

          // ── 声明二：不获取地理位置 ───────────────────
          _SectionTitle(title: '二、不获取地理位置'),
          const SizedBox(height: 10),
          _PrivacyItem(
            icon: Icons.location_off_rounded,
            title: '本应用不请求也不使用任何位置信息',
            content: '本应用的随机菜品功能与用户所在位置完全无关，'
                '因此本应用不会以任何方式请求或使用地理位置信息，包括：\n\n'
                '• GPS 卫星定位\n'
                '• 基站网络定位\n'
                '• Wi-Fi 热点定位\n'
                '• IP 地址粗略定位\n\n'
                '用户无需授权任何位置权限，应用即可正常运行全部功能。',
            colorScheme: colorScheme,
          ),

          const SizedBox(height: 16),

          // ── 声明三：餐饮数据说明 ─────────────────────
          _SectionTitle(title: '三、餐饮数据说明'),
          const SizedBox(height: 10),
          _PrivacyItem(
            icon: Icons.fastfood_rounded,
            title: '所有菜品数据均为公开测试数据',
            content: '本应用中展示的全部餐饮数据（菜品名称、菜系分类等）均为公开测试数据，具体说明如下：\n\n'
                '• 数据来源：由项目组成员自行整理，基于日常通用菜名和常识性分类\n'
                '• 数据格式：JSON 文件，托管于 Gitee 公开仓库，任何人可查阅\n'
                '• 数据性质：不涉及任何真实餐厅、商户、菜单价格或用户的真实订餐记录\n'
                '• 使用目的：仅供本课程项目教学演示与功能测试\n\n'
                '本数据不构成任何商业推荐，也不与任何第三方平台或商家存在利益关系。',
            colorScheme: colorScheme,
          ),

          const SizedBox(height: 16),

          // ── 声明四：网络权限与合规 ───────────────────
          _SectionTitle(title: '四、网络安全与隐私规范'),
          const SizedBox(height: 10),
          _PrivacyItem(
            icon: Icons.verified_user_rounded,
            title: '遵循相关法律法规，坚持最小权限原则',
            content: '本应用遵循以下法律法规及行业规范：\n\n'
                '• 《中华人民共和国网络安全法》\n'
                '• 《中华人民共和国个人信息保护法》\n'
                '• 《App 违法违规收集使用个人信息行为认定方法》\n'
                '• 《常见类型移动互联网应用程序必要个人信息范围规定》\n\n'
                '在权限使用方面，本应用坚持最小权限原则：\n'
                '仅申请 Flutter Web 应用运行所需的网络访问能力（用于加载菜品 JSON 数据），'
                '不申请存储、摄像头、麦克风、通讯录等任何敏感权限。',
            colorScheme: colorScheme,
          ),

          const SizedBox(height: 28),

          // ── 权限汇总表 ──────────────────────────────
          Text(
            '权限申请汇总',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          _PermissionTable(colorScheme: colorScheme),

          const SizedBox(height: 28),

          // ── 底部提示 ────────────────────────────────
          Card(
            color: colorScheme.tertiaryContainer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded,
                      color: colorScheme.onTertiaryContainer, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '本应用为移动应用软件开发实训课程项目，仅供教学演示，不涉及任何商业运营。'
                      '如您对本应用的隐私保护有任何疑问，请联系课程教师或项目组长。',
                      style: TextStyle(
                        color: colorScheme.onTertiaryContainer,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // ── 版本信息 ────────────────────────────────
          Center(
            child: Text(
              '项目名称：今天吃啥（Random Food Picker）\n版本：v1.0.0　·　更新日期：2026 年 6 月',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.7,
                  ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── 章节标题 ──────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
        ),
      ],
    );
  }
}

// ── 隐私声明条目 ──────────────────────────────────────
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
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.secondary, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.7,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 权限汇总表格 ──────────────────────────────────────
class _PermissionTable extends StatelessWidget {
  const _PermissionTable({required this.colorScheme});
  final ColorScheme colorScheme;

  static const List<_PermRow> _rows = [
    _PermRow('INTERNET（网络访问）', '是', '加载 Gitee 菜品 JSON 数据'),
    _PermRow('ACCESS_FINE_LOCATION（精确位置）', '否', '—'),
    _PermRow('ACCESS_COARSE_LOCATION（粗略位置）', '否', '—'),
    _PermRow('READ_EXTERNAL_STORAGE（读取存储）', '否', '—'),
    _PermRow('CAMERA（摄像头）', '否', '—'),
    _PermRow('READ_CONTACTS（通讯录）', '否', '—'),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // 表头
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Text('权限名称',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant))),
                Expanded(
                    flex: 2,
                    child: Text('是否申请',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant))),
                Expanded(
                    flex: 4,
                    child: Text('用途说明',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant))),
              ],
            ),
            const Divider(height: 12),
            ..._rows.map((r) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 5,
                          child: Text(r.name,
                              style: const TextStyle(fontSize: 12))),
                      Expanded(
                          flex: 2,
                          child: Text(r.applied,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: r.applied == '是'
                                      ? colorScheme.primary
                                      : colorScheme.onSurfaceVariant))),
                      Expanded(
                          flex: 4,
                          child: Text(r.desc,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: colorScheme.onSurfaceVariant))),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _PermRow {
  const _PermRow(this.name, this.applied, this.desc);
  final String name;
  final String applied;
  final String desc;
}
