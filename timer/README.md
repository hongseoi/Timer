# timer

A new Flutter project.

## 상태

1. 타이머의 시간
2. 현재까지 완료한 뽀모도로의 개수
3. 현재 타이머의 상태
    * 작업 중 (running)
    * 정지 (stopped)
    * 일시정지 (paused)
    * 휴식 중 (resting)

## 타이머 이벤트 정의하기
1. 시작하기 버튼 누르기 run: Status.stopped -> Status.running
2. 작업 타이머 시간이 끝나 휴식 타이머 시작 rest : Status.running -> Status.resting
3. 일시정지 버튼 누르기 pause: Status.running -> Status.paused
4. 계속하기 버튼 누르기 resume: Status.paused -> Status.running
5. 포기하기 버튼 누르기 / 휴식 타이머 시간 끝남 stop : Status.paused or Status.running or Status.resting -> Status.stopped


## 타이머 상태 구현에 도움을 주는 문법

enum A {1, 2, 3}

A myVal = A.a;
if (myVal == A.b) return 'B!';

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
