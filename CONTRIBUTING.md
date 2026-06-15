# 协作说明（给组员）

## 1. 第一次拉取代码

打开 PowerShell / 终端：

```bash
git clone https://github.com/t-1tian/flutter_food_picker.git
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
git checkout main
git pull origin main

# 首次创建自己的开发分支
git checkout -b dev/A

# 推送到 GitHub
git push -u origin dev/A
```

第二次以后，**永远在自己分支上工作**：

```bash
git checkout dev/A
# ... 写代码 ...
git add .
git commit -m "feat: xxx"
git push origin dev/A
```

## 3. 如何合并到 main？

⚠️ **不要直接往 main 推代码！** 必须走 Pull Request 流程：

1. 把代码推到自己的分支
2. 打开 GitHub 仓库：https://github.com/t-1tian/flutter_food_picker
3. 点击 **「Compare & pull request」** 按钮
4. 选择：`base: main` ← `compare: dev/A`
5. 写清楚这次改了什么、怎么测试
6. @F 同学 review 通过后合并

## 4. 遇到冲突怎么办？

```bash
git checkout dev/A
git fetch origin
git merge origin/main
# 如果有冲突，打开冲突文件手动解决
git add .
git commit -m "merge: 解决与 main 的冲突"
git push origin dev/A
```

不会解决冲突的话，截图发群里，F 同学会协助。

## 5. 推送前自检

- ✅ 编译能通过（`flutter run` 不报错）
- ✅ 关键功能在 Chrome 或真机上能跑
- ✅ 截图保存到 `screenshots/` 文件夹
- ✅ 截图一起 commit（commit message 写明 "含截图"）

## 6. 不想装 Flutter？直接看 Web 预览

👉 https://t-1tian.github.io/flutter_food_picker/

F 同学合并代码后会重新部署。
