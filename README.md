# flutter (mvvm) + supabase


[supabase flutter文档](https://supabase.com/docs/reference/dart/auth-signup)

### 开发环境
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
### build
```
cat > build.sh <<'EOF'

#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUPABASE_URL="https://xxx.supabase.co"
SUPABASE_ANON_KEY="sb_publishable_xxx"

cd "$ROOT_DIR"

build_web() {
  echo "==> Building Web"
  flutter build web \
    --dart-define=SUPABASE_URL="$SUPABASE_URL" \
    --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"

  echo "==> Web build finished"
  echo "Web output: build/web"
}

build_apk() {
  echo "==> Building Android APK"
  flutter build apk --release \
    --dart-define=SUPABASE_URL="$SUPABASE_URL" \
    --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"

  echo "==> APK build finished"
  echo "APK output: build/app/outputs/flutter-apk/app-release.apk"
}

echo "==> Getting Flutter dependencies"
flutter pub get

echo "Select build target:"
echo "1) Web"
echo "2) Android APK"
read -r -p "Enter 1 or 2: " choice

case "$choice" in
  1)
    build_web
    ;;
  2)
    build_apk
    ;;
  *)
    echo "Invalid choice: $choice"
    exit 1
    ;;
esac

EOF
```