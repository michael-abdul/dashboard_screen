#!/bin/bash

# 로그 함수
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

#PRODUCTION
log "Git 리포지토리 초기화 중..."
git reset --hard
log "Git master 브랜치로 전환 중..."
git checkout master
log "Git 최신 변경사항을 가져오는 중..."
git pull origin master

# 2. 플러터 설정

log "Flutter 캐시 정리 중..."
flutter clean
log "Flutter 의존성 설치 중..."
flutter pub get
log " Flutter build 중..."
flutter build web
log "Flutter 웹 빌드 완료..."

# 3. Nginx 설정
sudo ln -s /etc/nginx/sites-available/dashboard_screen /etc/nginx/sites-enabled/
log "새로운 설정 파일이 활성화됨됨:/etc/nginx/sites-available/dashboard_screen"
log "Nginx 설정 테스트 중..."
sudo nginx -t
log "Nginx 재시작 중..."
sudo systemctl restart nginx
log "Nginx 성공적으로 재시작됨"
# 완료
log "배포가 성공적으로 완료되었습니다!"