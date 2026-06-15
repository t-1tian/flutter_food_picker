# 项目交付说明（给组员）

## 1. 第一次拉取代码

打开 PowerShell / 终端：

```bash
# 克隆仓库
git clone https://gitee.com/svtyt/flutter_food_picker.git
cd flutter_food_picker
```

## 2. 创建并切换到自己的开发分支

| 你的角色 | 你的分支 |
|----------|----------|
| A 同学 | dev/A |
| B 同学 | dev/B |
| C 同学 | dev/C |
| D 同学 | dev/D |
| E 同学 | dev/E |
| F 同学 | dev/F |

以 A 同学为例：

```bash
# 拉取最新的 main
git checkout main
git pull origin main

# 切到自己的分支（首次创建）
git checkout -b dev/A

# 推送到 Gitee
git push -u origin dev/A
```

第二次以后，**永远在自己分支上工作**：

```bash
git checkout dev/A        # 切到自己的分支
# ... 写代码 ...
git add .
git commit -m "feat: xxx"
git push origin dev/A
```

## 3. 如何合并到 main？

⚠️ **不要直接往 main 推代码！** 必须走 Pull Request 流程：

1. 把代码推到自己的分支
2. 打开 Gitee 仓库：https://gitee.com/svtyt/flutter_food_picker
3. 点击左侧 **「Pull Request」→ 「新建 Pull Request」**
4. 选择：`源分支 dev/A` → `目标分支 main`
5. 写清楚这次改了什么、怎么测试
6. @F 同学 review 通过后合并

## 4. 遇到冲突怎么办？

```bash
# 先把 main 拉下来
git checkout dev/A
git fetch origin
git merge origin/main
# 如果有冲突，打开冲突文件手动解决，然后：
git add .
git commit -m "merge: 解决与 main 的冲突"
git push origin dev/A
```

不会解决冲突的话，截图发群里，F 同学会协助。

## 5. 推送前自检

- ✅ 编译能通过（`flutter run` 不报错）
- ✅ 关键功能在 Chrome 或真机上能跑
- ✅ 截图保存到 `screenshots/` 文件夹
- ✅ 截图一起提交（commit message 写明 "含截图"）
