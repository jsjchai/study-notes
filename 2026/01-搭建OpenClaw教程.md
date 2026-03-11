# 搭建OpenClaw教程

## 概述
OpenClaw是一个功能强大的AI助手平台，支持多模态交互和自动化任务。本教程将详细介绍如何搭建和配置OpenClaw环境。

## 系统要求
- **操作系统**: macOS, Linux, Windows (WSL2)
- **Node.js**: v18.0.0 或更高版本
- **Python**: 3.8 或更高版本（可选，用于某些功能）
- **内存**: 至少 4GB RAM
- **磁盘空间**: 至少 2GB 可用空间

## 安装步骤

### 1. 安装Node.js和npm
```bash
# 使用nvm安装Node.js（推荐）
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 18
nvm use 18

# 或者使用系统包管理器
# macOS (Homebrew)
brew install node

# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### 2. 安装OpenClaw
```bash
# 全局安装OpenClaw
npm install -g openclaw

# 验证安装
openclaw --version
```

### 3. 初始化配置
```bash
# 初始化OpenClaw配置
openclaw init

# 按照提示完成配置：
# 1. 选择工作目录（默认：~/.openclaw）
# 2. 配置API密钥（可选）
# 3. 设置默认模型
```

### 4. 启动OpenClaw服务
```bash
# 启动网关服务
openclaw gateway start

# 检查服务状态
openclaw gateway status

# 停止服务
openclaw gateway stop
```

## 基本配置

### 配置文件位置
OpenClaw的主要配置文件位于：
- `~/.openclaw/config.json` - 主配置文件
- `~/.openclaw/workspace/` - 工作空间目录

### 配置API密钥
编辑配置文件添加API密钥：
```json
{
  "providers": {
    "openai": {
      "apiKey": "sk-your-openai-api-key"
    },
    "anthropic": {
      "apiKey": "your-anthropic-api-key"
    },
    "google": {
      "apiKey": "your-google-api-key"
    }
  }
}
```

### 模型配置
```json
{
  "agents": {
    "defaults": {
      "model": "openai/gpt-4o",
      "thinking": "off"
    }
  }
}
```

## 常用命令

### 服务管理
```bash
# 启动服务
openclaw gateway start

# 停止服务
openclaw gateway stop

# 重启服务
openclaw gateway restart

# 查看状态
openclaw gateway status
```

### 会话管理
```bash
# 查看当前会话
openclaw sessions list

# 发送消息
openclaw send "你好，OpenClaw！"

# 运行一次性任务
openclaw run "帮我查看当前天气"
```

### 技能管理
```bash
# 列出可用技能
openclaw skills list

# 安装技能
openclaw skills install <skill-name>

# 更新技能
openclaw skills update
```

## 工作空间结构

```
~/.openclaw/workspace/
├── AGENTS.md          # 代理配置文档
├── SOUL.md           # 个性配置文件
├── USER.md           # 用户信息
├── TOOLS.md          # 工具配置
├── HEARTBEAT.md      # 心跳任务
├── MEMORY.md         # 长期记忆
└── memory/           # 每日记忆文件
    ├── 2026-03-01.md
    └── 2026-03-02.md
```

## 核心功能

### 1. 多模态交互
- 文本对话
- 图像分析
- 语音合成（TTS）
- 文件处理

### 2. 自动化任务
- 定时任务（cron）
- 心跳检查
- 工作流自动化

### 3. 扩展技能
- 天气查询
- 网页搜索
- 代码执行
- 系统监控

### 4. 记忆系统
- 短期记忆（每日文件）
- 长期记忆（MEMORY.md）
- 上下文感知

## 高级配置

### 自定义技能
创建自定义技能目录：
```bash
mkdir -p ~/.openclaw/skills/my-skill
```

创建技能配置文件 `SKILL.md`：
```markdown
# 我的自定义技能

## 描述
这是一个自定义技能示例。

## 使用方法
调用方式：`my-skill <参数>`

## 配置
无特殊配置要求。
```

### 集成外部服务
OpenClaw支持多种外部服务集成：
- **日历**: Google Calendar, Outlook
- **邮件**: Gmail, SMTP
- **消息**: Telegram, Discord, Slack
- **云存储**: Dropbox, Google Drive

### 安全配置
```json
{
  "security": {
    "allowedHosts": ["localhost", "127.0.0.1"],
    "maxFileSize": 10485760,
    "requireAuth": true
  }
}
```

## 故障排除

### 常见问题

1. **服务启动失败**
   ```bash
   # 检查端口占用
   lsof -i :3000
   
   # 查看日志
   openclaw gateway logs
   ```

2. **API连接问题**
   ```bash
   # 测试API连接
   openclaw test-api
   
   # 检查网络
   curl https://api.openai.com/v1/models
   ```

3. **内存不足**
   ```bash
   # 查看内存使用
   openclaw status
   
   # 清理缓存
   openclaw cleanup
   ```

### 日志查看
```bash
# 查看网关日志
openclaw gateway logs

# 查看会话日志
openclaw sessions logs <session-id>

# 调试模式
openclaw --debug gateway start
```

## 最佳实践

### 1. 定期备份
```bash
# 备份工作空间
tar -czf openclaw-backup-$(date +%Y%m%d).tar.gz ~/.openclaw/workspace/
```

### 2. 版本控制
```bash
# 初始化Git仓库
cd ~/.openclaw/workspace
git init
git add .
git commit -m "初始提交"
```

### 3. 性能优化
- 定期清理日志文件
- 限制并发会话数
- 使用轻量级模型

### 4. 安全建议
- 定期更新OpenClaw版本
- 使用强密码保护API密钥
- 限制外部访问

## 扩展资源

### 官方文档
- [OpenClaw文档](https://docs.openclaw.ai)
- [GitHub仓库](https://github.com/openclaw/openclaw)
- [社区Discord](https://discord.com/invite/clawd)

### 学习资源
- 官方示例项目
- 社区贡献的技能
- 教程视频

### 社区支持
- GitHub Issues
- Discord社区
- 邮件列表

## 更新日志

### 2026-03-02
- 创建OpenClaw搭建教程
- 涵盖安装、配置、使用全流程
- 添加故障排除和最佳实践

---

**提示**: OpenClaw持续更新，建议定期查看官方文档获取最新信息。

---

**标签**: #tutorial #OpenClaw #AI助手  
**最后更新**: 2026-03-02  
**维护者**: chai