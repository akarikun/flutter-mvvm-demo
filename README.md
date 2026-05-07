# flutter (mvvm) + supabase


[supabase flutter文档](https://supabase.com/docs/reference/dart/auth-signup)

### 创建开发环境
```
cat > .env <<'EOF'
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_ANON_KEY=sb_publishable_xxx
EOF
```
### vscode debug

```
mkdir -p .vscode
cat > .vscode/launch.json <<'EOF'
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "flweb",
      "request": "launch",
      "type": "dart",
      "deviceId": "chrome",
      "program": "lib/main.dart",
      "toolArgs": [
        "--dart-define=SUPABASE_URL=https://xxx.supabase.co",
        "--dart-define=SUPABASE_ANON_KEY=sb_publishable_xxx"
      ]
    }
  ]
}
EOF
```