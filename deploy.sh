#!/bin/bash

# 서버의 프로젝트 경로 (수정 필요)
SERVER_PATH="/var/www/my_flutter_ui/dashboard_screen"

# 로그 함수
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# 1. Flutter 빌드
log "Flutter 웹 앱 빌드 중..."
cd $SERVER_PATH || { log "오류: $SERVER_PATH로 이동 실패"; exit 1; }
flutter build web --release
if [ $? -ne 0 ]; then
    log "오류: Flutter 웹 앱 빌드 실패."
    exit 1
fi

# 2. 권한 설정
log "서버 권한 설정 중..."
chmod -R 755 $SERVER_PATH/build/web
chown -R www-data:www-data $SERVER_PATH/build/web
if [ $? -ne 0 ]; then
    log "오류: 권한 설정 실패."
    exit 1
fi

# 3. Nginx 재시작
log "Nginx 재시작 중..."
systemctl restart nginx
if [ $? -ne 0 ]; then
    log "오류: Nginx 재시작 실패."
    exit 1
fi

# 완료
log "배포가 성공적으로 완료되었습니다!"