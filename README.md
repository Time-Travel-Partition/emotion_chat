# emotion_chat

당신의 감정에 귀 기울이며, Emotion Chat (가제)

## 플러터 폴더 구조
📦lib
 ┣ 📂models
 ┣ 📂screens
 ┃ ┣ 📂auth
 ┃ ┗ 📂main
 ┃ ┃ ┣ 📂chat_tab
 ┃ ┃ ┣ 📂home_tab
 ┃ ┃ ┗ 📂profile_tab
 ┣ 📂widgets
 ┣ 📂services
 ┃ ┣ 📂auth
 ┃ ┣ 📂chat
 ┃ ┗ 📂image
 ┃ ┃ ┣ 📂firebase_storage
 ┃ ┃ ┗ 📂local_storage
 ┣ 📂themes
 ┗ 📂utils

- models : 애플리케이션의 데이터 모델을 정의합니다.
- screens : 사용자에게 노출되는 화면들을 관리합니다.
- widgets : 여러 화면에서 재사용 가능한 위젯들이 포함됩니다.
- services : API 호출 혹은 데이터베이스와 상호작용합니다.
- utils : 전역적으로 사용되는 비즈니스 로직을 저장합니다.