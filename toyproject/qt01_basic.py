## PyQt5 첫 개발 ~~!
 # 첫 윈도우 앱 개발~! ; WinApp

import sys
from PyQt5.QtWidgets import *  # sql과 똑같이 *는 all의 기능을 하는구나 ~

# PyQt의 모든 컨트롤은 Widget(위젯)이라고 부른대~!
class DevWindow(QMainWindow):  # QtWidget에 들어 있는 기능임 !! / 클래스 선언!
    #pass  오류를 없애줌 ! 대신 아무 일도 안 함...
    def __init__(self):        # 클래스 초기화 스페셜메서드
        super().__init__()     # 부모클래스 QMainWindow도 초기화

app = QApplication(sys.argv)   # 애플리케이션 인스턴스 생성
win = DevWindow()              # PyQt로 만들어진 클래스 인스턴스 생성
win.show()                     # 윈도우 바탕화면에 띄워줘 !
app.exec_()                    # 애플리케이션이 X버튼을 눌러서 종료되기 전까지 실행 !!              