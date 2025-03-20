#### 20250319 sql 7번째 수업!!! 근데 한 달이나 지난 것 같아!!!!
## 토이프로젝트
    ; Python GUI - ORacle 연동 프로그램

### GUI 프레임워크
    > 요새는 파이썬으로도 다 만들 수 있대~

- GUI 프레임워크 종류
    1. tkinter : 파이썬에 내장된 GUI 라이브러리, 중소형 프로그램. *간단하게 사용 가능!*
        > 따로 깔지 않아도 됨 !! **근데 안 예쁨**

    2. PyQt / PySide : C/C++에서 사용하는 GUI 프레임워크 Qt를 파이썬에 사용하게 만든 라이브러리.
        > 현재 6버전 출시, **유료**
        - PyQt의 사용라이선스 문제로 PySide 출시.
            > PyQt에서 PySide로 변경하는데 번거로움이 존재 !
        - tkinter보다 난이도가 있음 
        - **아주 예쁨.** Qtdesigner툴로 포토샵처럼 GUI를 디자인 가능 !!
            > Python GUI 중에서 가장 많이 사용 중 !!

    3. Kivy
        - OpenGL(게임엔진용 3D 그래픽엔진)으로 구현되는 GUI 프레임워크
        - 안드로이드, iOS 등 모바일용으로도 개발 가능!! (다양한 플랫폼 지원)
        - 최신 기술이라 아직 불안정함.

    4. wxPython
        - Kivy처럼 멀티플랫폼 GUI 프레임워크
        - **무지 어려움**

### PyQt5 GUI 사용 !!
- PyQt5 설치
    - 콘솔 `>pip install PyQt5`
    > 항상 최신 버전이 좋은 것만은 아니다~

- QtDesigner 설치
    > https://build-system.fman.io/qt-designer-download 다운로드 후 설치

    <img src="../image/db007.png" width="600">

#### PyQt5 개발
1. PyQt 모듈 사용 윈앱 만들기
2. 윈도우 기본설정
3. PyQt 위젯 사용법(레이블, 버튼, ...)
4. 시그널(이벤트) 처리방법
5. QtDesigner로 화면디자인, PyQt와 연동

    <img src="../image/db006.png" width="600">

#### Oracle연동 GUI개발 시작!!
- 오라클 Python연동 DB(스키마) 생성
    ```sql
    --sys(sysdba)로 작업
-- 20250319 파이썬과 데이터베이스 연동 !!

-- madang 스키마, 사용자 생성
CREATE USER madang IDENTIFIED BY madang;

-- 권한 설정
GRANT CONNECT, resource TO madang;

-- madang으로 사용 및 스키마 변경 !!

-- 테이블 Student 생성
CREATE TABLE Students (
	std_id 		NUMBER PRIMARY KEY,
	std_name 	varchar2(100) NOT NULL,
	std_mobile 	varchar2(15) NULL,
	std_regyear number(4,0) NOT NULL
);

-- Students용 시퀀스 생성
CREATE SEQUENCE SEQ_STUDENT
	INCREMENT BY 1     -- 숫자를 1씩 증가
	START WITH 1; 	   -- 1부터 숫자가 증가됨
    ```

- Student 테이블 생성, 더미데이터 추가
    ```sql
    -- madang으로 로그인
    -- 조회
    SELECT * FROM Students;

    -- 더미데이터 삽입
    INSERT INTO Students (std_id, std_name, std_mobile, std_regyear)
    VALUES(SEQ_STUDENT.nextval, '홍길동', '010-9999-8888', 1997);

    INSERT INTO Students (std_id, std_name, std_mobile, std_regyear)
    VALUES(SEQ_STUDENT.nextval, '홍길순', '010-9999-8877', 2000);

    COMMIT;
    ```

#### 20250320 sql 8일차 수업 !!!!!!
## 7,8일차 !!!
- Python 오라클 연동 테스트
    - 오라클 모듈
        - oracledb - Oracle 최신버전에 매칭 (**구버전은 안 됨!**)
        - **cx_Oracle** - 구버전까지 잘 됨!
    - [Microsoft C++ Build Tools](https://visualstudio.microsoft.com/ko/visual-cpp-build-tools/) 필요 !
    - Visual Studio Installer 실행
    - 개별 구성요소에서 아래 요소 선택
        - [x] MSVC v1XX - VS 20XX C++ x64/x86 빌드도구
        - [x] C++ CMake Tools for Window
        - [x] Windows 10 SDK(10.0.xxxx)
    - 설치
        - 콘솔에서 `> pip insatall cx_Oracle`
        - 콘솔 오라클연동 : [python](./)
        - DPI-1047오류 발생
        - 64-bit Oracle Client Library가 현재 OS에 설치되지 않았기 때문에 발생하는 현상 !!
        - 아래 사이트에서 버전에 맞는 ORacle Client를 다운로드
        - https://www.oracle.com/kr/database/technologies/instant-client/winx64-64-downloads.html
        - 11g 다운로드
        - 압축해제, 시스템정보 path 등록
        - 재부팅 !
    - 콘솔 테스트 결과
        <img src="../image/db008.png" width="600    ">


- QtDesigner로 화면 구성

- PyQt로 Oracle 연동 CRUD 구현
    - [토이프로젝트](./madang_작업쿼리.sql)

