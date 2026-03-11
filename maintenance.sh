#!/bin/bash

# study-notes项目自动维护脚本
# 作者: OpenClaw AI助手
# 创建时间: 2026年3月2日

set -e  # 遇到错误时退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# 项目路径
PROJECT_DIR="/Users/jsjchai/.openclaw/workspace/study-notes"
BACKUP_DIR="/Users/jsjchai/.openclaw/workspace/backups"

# 创建备份目录
mkdir -p "$BACKUP_DIR"

# 1. 备份当前状态
backup_project() {
    log_info "开始备份项目..."
    local backup_file="$BACKUP_DIR/study-notes-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
    tar -czf "$backup_file" -C "$PROJECT_DIR" .
    if [ $? -eq 0 ]; then
        log_success "项目备份完成: $backup_file"
        # 保留最近7天的备份
        find "$BACKUP_DIR" -name "study-notes-backup-*.tar.gz" -mtime +7 -delete
    else
        log_error "项目备份失败"
        exit 1
    fi
}

# 2. 检查Git状态
check_git_status() {
    log_info "检查Git状态..."
    cd "$PROJECT_DIR"
    
    # 检查是否在Git仓库中
    if [ ! -d ".git" ]; then
        log_error "当前目录不是Git仓库"
        exit 1
    fi
    
    # 检查远程仓库配置
    if ! git remote -v | grep -q "origin"; then
        log_warning "未配置远程仓库，正在配置..."
        git remote add origin https://github.com/jsjchai/study-notes.git
    fi
    
    # 检查本地更改
    local changes=$(git status --porcelain)
    if [ -n "$changes" ]; then
        log_warning "发现未提交的更改:"
        echo "$changes"
        return 1
    else
        log_success "没有未提交的更改"
        return 0
    fi
}

# 3. 同步远程更改
sync_with_remote() {
    log_info "同步远程更改..."
    cd "$PROJECT_DIR"
    
    # 拉取远程更新
    log_info "拉取远程更新..."
    if git pull origin master; then
        log_success "拉取远程更新成功"
    else
        log_error "拉取远程更新失败"
        return 1
    fi
    
    # 推送本地更改（如果有）
    local changes=$(git status --porcelain)
    if [ -n "$changes" ]; then
        log_info "提交并推送本地更改..."
        git add .
        git commit -m "自动维护: $(date '+%Y-%m-%d %H:%M:%S')"
        if git push origin master; then
            log_success "推送更改成功"
        else
            log_error "推送更改失败"
            return 1
        fi
    else
        log_success "没有需要推送的更改"
    fi
    
    return 0
}

# 4. 检查项目完整性
check_project_integrity() {
    log_info "检查项目完整性..."
    cd "$PROJECT_DIR"
    
    local errors=0
    
    # 检查必要目录
    local required_dirs=("2018" "2019" "2020" "2021" "2022" "2023" "2024" "2025" "2026" "templates" "resources")
    for dir in "${required_dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            log_error "缺少必要目录: $dir"
            errors=$((errors + 1))
        fi
    done
    
    # 检查必要文件
    local required_files=("README.md" "MAINTENANCE_PLAN.md")
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            log_error "缺少必要文件: $file"
            errors=$((errors + 1))
        fi
    done
    
    # 检查README.md是否包含必要内容
    if grep -q "学习笔记" "README.md"; then
        log_success "README.md格式正确"
    else
        log_warning "README.md可能缺少必要内容"
    fi
    
    if [ $errors -eq 0 ]; then
        log_success "项目完整性检查通过"
        return 0
    else
        log_error "项目完整性检查发现 $errors 个问题"
        return 1
    fi
}

# 5. 生成统计报告
generate_stats_report() {
    log_info "生成统计报告..."
    cd "$PROJECT_DIR"
    
    local report_file="STATS_REPORT_$(date +%Y%m%d).md"
    
    cat > "$report_file" << EOF
# Study-Notes 项目统计报告
**生成时间**: $(date '+%Y-%m-%d %H:%M:%S')

## 📊 基本统计

### 笔记数量统计
EOF
    
    # 统计各年份笔记数量
    echo "| 年份 | 笔记数量 |" >> "$report_file"
    echo "|------|----------|" >> "$report_file"
    
    for year in {2018..2026}; do
        if [ -d "$year" ]; then
            local count=$(find "$year" -name "*.md" -type f | wc -l | tr -d ' ')
            echo "| $year | $count |" >> "$report_file"
        fi
    done
    
    # 统计总笔记数
    local total=$(find . -name "*.md" -type f | grep -v ".git" | wc -l | tr -d ' ')
    echo "" >> "$report_file"
    echo "**总笔记数量**: $total 篇" >> "$report_file"
    
    # Git状态
    echo "" >> "$report_file"
    echo "## 🔄 Git状态" >> "$report_file"
    echo '```' >> "$report_file"
    git log --oneline -5 >> "$report_file" 2>/dev/null || echo "无法获取Git日志" >> "$report_file"
    echo '```' >> "$report_file"
    
    log_success "统计报告已生成: $report_file"
}

# 6. 主函数
main() {
    log_info "开始study-notes项目维护..."
    log_info "项目目录: $PROJECT_DIR"
    
    # 执行维护步骤
    backup_project
    check_git_status
    sync_with_remote
    check_project_integrity
    generate_stats_report
    
    log_success "项目维护完成！"
    echo ""
    echo "📋 维护总结:"
    echo "  ✅ 项目备份完成"
    echo "  ✅ Git状态检查完成"
    echo "  ✅ 远程同步完成"
    echo "  ✅ 项目完整性检查完成"
    echo "  ✅ 统计报告已生成"
    echo ""
    echo "🔗 GitHub仓库: https://github.com/jsjchai/study-notes"
    echo "📊 最新统计: 查看 STATS_REPORT_*.md 文件"
}

# 执行主函数
main "$@"