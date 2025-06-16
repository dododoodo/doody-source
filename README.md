

## 📢 소개
사용자가 직접 밸런스 게임을 만들고, 다른 사람들과 함께 즐길 수 있는 SPA 웹사이트, <b>"Doody"</b> 입니다. <br>

다른 사용자들이 만든 다양한 밸런스 게임을 한눈에 모아보고, <br>
클릭 한 번으로 간편하게 참여할 수 있습니다. <br>

간편한 등록 및 삭제 기능, 그리고 사용자 맞춤형 테마·폰트 설정을 통해 <br>
편리하고 유연한 사용 경험을 제공합니다. <br>

모바일(480px) 환경에 최적화된 반응형 디자인과 직관적인 UI로, <br>
누구나 쉽게 사용할 수 있도록 구성했습니다.


## 🔗 배포 URL
https://doody-nine.vercel.app/

## 📑 프로젝트 요약

### 1. 주제

* 밸런스 게임을 중심으로 한 사용자 참여형 커뮤니티 웹

### 2. 목표

* 사용자가 밸런스 게임을 통해 서로의 생각을 공유하고 소통할 수 있도록 한다.
* 별도의 회원가입 없이도 게임 생성, 삭제 등 기본 기능을 쉽게 수행할 수 있게 한다.
* 테마 및 폰트 설정 등 개인 맞춤 기능을 통해 사용자 경험의 만족도를 높인다.

### 3. 핵심 기능

* 밸런스 게임 참여 및 결과 확인
* 게임 생성 및 비밀번호 기반 삭제
* 반응 기능 (👍, 👎)
* 게임 목록 탐색 및 검색 기능
* 다크모드/라이트모드, 폰트 크기 설정 등 커스터마이징 지원

### 4. 주요 기술 스택

* Front-End : Flutter
* Back-End : PHP, XAMPP
* Data-Base : MySQL

## 📆 기간 및 인원

  * 총 작업 기간 : 7일
    * 기초 데이터 수집 및 화면 설계 기간 : 2일
    * 개발 및 테스트 기간 : 5일
   
  * 팀원 : 2명

## 👩🏻‍🤝‍🧑🏻 팀원 소개

| 이름 | 주요 페이지 컴포넌트 | 해당 |
| :---: | :---: | :---: |
| 김도연 | main.dart, Home.dart |  |
| 천지호 | NewPost.dart, Settings.dart, splash.dart | ✔ |

## 💡 주요 기능

### 1. 검색
* 원하는 주제나 게임을 손쉽게 탐색 가능
* 실시간 검색어 입력에 반응하여 빠르게 결과 확인 가능

### 2. 밸런스 게임 참여
* 클릭을 통해 게임 참여 및 결과 확인 가능
* 좋아요/싫어요 버튼을 통해 반응을 남겨 의견 표현
* 게임 생성 시 설정한 비밀번호가 일치할 경우 해당 게임 삭제

### 3. 밸런스 게임 등록
* 원하는 질문과 두 가지 선택지를 입력하여 나만의 밸런스 게임 생성
* 등록된 게임은 목록에 바로 반영

### 4. 커스터마이징 (테마, 폰트)
* 토글 스위치를 통해 라이트 모드/다크 모드를 간편하게 변경 가능
* 슬라이더를 사용해 텍스트 크기를 3단계 중 원하는 크기로 설정 가능

## 🗂️ 폴더 구조

```
📂doody
┣ 📂front                     # doody ( Front-End_Flutter )
┃ ┣ 📂assets
┃ ┃ ┣ 📂fonts
┃ ┃ ┣ 📂imgs
┃ ┣ 📂lib
┃ ┃ ┣ 📂components            # 컴포넌트 폴더
┃ ┃ ┣ 📂constants             # text style 및 color 정의 폴더
┃ ┃ ┗ 📂controller            # Hive/GetX controller 폴더
┃ ┃ ┣ 📂screen                # 각 페이지 컴포넌트 폴더
┃ ┃ ┣ 📂theme                 # light/dark theme 정의 폴더
┃ ┃ ┗ 📂widget                # 위젯 폴더
┃ ┃ ┗ 📜main.dart             # 전체 위젯 트리 구성 파일
┃ ┣ ⚙️.env
┃ ┗ README.md
┣ 📂back                      # doody ( Back-End_PHP )
┃ ┣ 📂api                     # 데이터 가공 및 반환을 담당하는 API 파일들이 위치한 폴더
┃ ┣ 📜config.php
┗ ┗ 📜table.php
```

## 💻 개발 환경

### 1. Front-End

| 사용기술 | 설명 |Badge |
| :---:| :---: | :---: |
| **Flutter** | **앱 전체 UI 프레임워크** |![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat-square&logo=Flutter&logoColor=white)|
| **Dart** | **Flutter 기본 언어** |![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)|
| **Hive** | **Local DB 저장** | ![Hive](https://img.shields.io/badge/Hive-2.2.3-yellow?style=flat-square) |
| **HTTP** | **REST API 통신** | ![HTTP](https://img.shields.io/badge/HTTP-1.4.0-informational?style=flat-square) |

### 2. UI/UX 라이브러리

| 사용기술 | 설명 | Badge |
| :---:| :---: | :---: |
| **GetX** | **라우팅 & 상태 관리 프레임워크** |![GetX](https://img.shields.io/badge/GetX-4.7.2-blueviolet?style=for-the-badge)|
| **flutter_svg** | **SVG 아이콘 및 이미지 지원** |![flutter_svg](https://img.shields.io/badge/flutter__svg-SVG-blue?style=flat-square)|
| **toggle_switch** | **커스텀 토글 스위치 UI 위젯** |![toggle_switch](https://img.shields.io/badge/toggle__switch-toggle-green?style=flat-square)|

### 3. Back-End

| 사용기술 | 설명 | Badge |
| :---:| :---: | :---: |
| **PHP** | **서버 측 로직 처리** |![PHP](https://img.shields.io/badge/PHP-8892BE?style=flat-square&logo=npm&logoColor=white)|
| **MySQL** | **데이터베이스 관리**  |![MySQL](https://img.shields.io/badge/MySQL-00758F?style=flat-square&logo=JSON&logoColor=white)|
| **XAMPP** | **Apache, MySQL, PHP를 통합 제공하는 로컬 서버 개발 도구** |![XAMPP](https://img.shields.io/badge/XAMPP-FB7A24?style=flat-square&logo=nodemon&logoColor=white)|

### 4. 개발 도구

|사용기술 | 설명 | Badge | 
| :---:| :---: | :---: |
| **Visual Studio Code (VS Code)** | **코드 편집기 (에디터)** |![VSCode](https://img.shields.io/badge/VSCode-007ACC?style=flat-square&logo=data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzIiIGhlaWdodD0iMzIiIHZpZXdCb3g9IjAgMCAzMiAzMiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTI0LjAwMyAyTDEyIDEzLjMwM0w0Ljg0IDhMMiAxMEw4Ljc3MiAxNkwyIDIyTDQuODQgMjRMMTIgMTguNzAyTDI0LjAwMyAzMEwzMCAyNy4wODdWNC45MTNMMjQuMDAzIDJaTTI0IDkuNDM0VjIyLjU2NkwxNS4yODkgMTZMMjQgOS40MzRaIiBmaWxsPSJ3aGl0ZSIvPgo8L3N2Zz4K&logoColor=white) |
|**GitHub** | **버전 관리** |![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=GitHub&logoColor=white)| 
| **Slack** | **협업** |![Slack](https://img.shields.io/badge/Slack-4A154B?style=flat-square&logo=slack&logoColor=white) |
| **Vercel** | **서버리스 플랫폼** |![vercel](https://img.shields.io/badge/Vercel-000000?style=flat-square&logo=vercel&logoColor=white)|
| **Figma** | **디자인 & UI/UX**|![Figma](https://img.shields.io/badge/Figma-F24E1E?style=flat-square&logo=Figma&logoColor=white) |

## 📚 참고 URL
- 기획 및 화면 설계 :
- 발표 자료 :
- 인터페이스 구현 보고서 :
- 프로젝트 완료 보고서 :

<hr>

# ***의 개발 상세

## 📑 요약

### 담당 페이지 목록

## 🧩 공통 컴포넌트

## 💥 이슈 및 해결
