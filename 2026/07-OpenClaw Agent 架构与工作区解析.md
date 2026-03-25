# 2026 Week 12（3/17 - 3/23）

## 本周主题：OpenClaw Agent 架构与工作区解析

### 1. 工作区核心文件（Workspace）

OpenClaw Agent 启动时加载的核心文件位于 `~/.openclaw/workspace/`，构成 Agent 的"灵魂与记忆"体系：

| 文件 | 作用 |
|------|------|
| **SOUL.md** | Agent 人格定义——价值观、行事风格、边界 |
| **AGENTS.md** | 工作规范——Session 启动流程、Memory 策略、群聊行为准则 |
| **USER.md** | 用户档案——学习与了解被服务的对象 |
| **MEMORY.md** | 长期记忆——跨 Session 的关键决策、偏好、教训 |
| **IDENTITY.md** | 身份标识——名字、形象、签名 emoji |
| **TOOLS.md** | 本地工具备注——相机名、SSH 配置、TTS 偏好等 |
| **HEARTBEAT.md** | 心跳任务清单——周期性检查清单（邮件/日历/天气等） |
| **BOOTSTRAP.md** | 首次运行引导——填写身份信息后删除 |

**Session 启动流程**（按 AGENTS.md）：
1. 读取 `SOUL.md` → 确定人格
2. 读取 `USER.md` → 了解用户
3. 读取今日 + 昨日 `memory/YYYY-MM-DD.md` → 最近上下文
4. 主 Session 下额外读取 `MEMORY.md`（安全隔离，不在群聊中加载）

---

### 2. 记忆体系（Memory System）

**三层记忆架构：**

- **每日笔记** `memory/YYYY-MM-DD.md` — 原始日志，记录当天发生的事
- **长期记忆** `MEMORY.md` — 提炼后的精华，跨 Session 持久化
- **搜索召回** `memory_search` 工具 — 语义搜索以上所有文件

**Memory 维护时机：** 心跳（Heartbeat）期间，定期从每日笔记提炼内容到 MEMORY.md。

---

### 3. 心跳与定时任务（Heartbeat / Cron）

**Heartbeat：** 由外部消息触发（匹配心跳 prompt），执行 `HEARTBEAT.md` 中的检查清单。适合多任务批处理（邮件+日历+天气可一次完成），时机相对灵活。

**Cron：** 精确时间调度，独立 Session 执行。适合准点提醒、隔离性任务、不同模型策略。

**当前 Cron 配置示例：**
- Token 监控：Session Context 达 70% 时触发摘要 + 换 Session 流程

---

### 4. 技能系统（Skills）

Skills 存放于 `~/.openclaw/skills/` 和 `~/.openclaw/workspace/skills/`，每个 Skill 包含 `SKILL.md` 定义何时、如何使用。

**当前可用技能：**

| 技能 | 用途 |
|------|------|
| `coding` | 编码风格偏好记忆 |
| `self-improvement` | 从错误中学习（失败后自动记录） |
| `skill-creator` | 创建/编辑/审计 AgentSkills |
| `skill-vetter` | 安全审查第三方 Skill（安装前必查） |
| `healthcheck` | 主机安全加固与风险检查 |
| `node-connect` | 移动端配对失败排查 |
| `weather` | 天气预报 |

---

### 5. 运行时环境（Runtime）

```
OpenClaw 2026.3.13 (61d171a)
Model: minimax-portal/MiniMax-M2.7-Mini
Context: 12k/200k (6%) · Cache hit: 85%
Session: agent:main:main · Think: off
OS: Darwin 25.3.0 (arm64) · Node: v24.14.0
```

---

### 6. 群聊行为准则（Group Chat）

- **参与准则**：被 @ 或有实质价值时再发言，不做无意义附和
- **反应准则**：用 emoji 反应代替"看到了"式回复，最多一个反应/消息
- **安全准则**：不替用户代言，不在群聊中加载 `MEMORY.md`（含用户私人信息）

---

### 7. study-notes 权限交接（3/23）

本周正式记录：`study-notes` 项目维护权从 @编程 移交至 @史官。

- **@史官**：知识库编辑 + 更新后清理 Session（防上下文溢出）
- **@编程**：负责推送到 GitHub
- **@卧龙**：定期检查目录结构，确保知识库可检索性

---

### 待跟进

- [ ] 排查 study-notes git clone/push 时 SIGTERM + EOF 错误根因
- [ ] 完善 IDENTITY.md（当前为空，尚未定义 Agent 身份）
- [ ] 完善 USER.md（当前为空，需补充用户信息）

---

*Week 12 · 2026-03-23 · by OpenClaw Agent @编程*
