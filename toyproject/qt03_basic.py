## PyQt5 첫 개발 ~~!
 # 첫 윈도우 앱 개발~! ; WinApp

import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *

class DevWindow(QMainWindow): 

    def __init__(self):       
        super().__init__()
        self.initUI()                    # 화면 디자인은 분리

    def initUI(self):                         # 화면 디자인
        self.setWindowTitle('My First App')  
        self.setWindowIcon(QIcon('./image/database.png'))
        self.setGeometry(300, 200, 600, 350)
        self.resize(600,350)                 

        # 라벨(레이블) 추가
        self.lbl1 = QLabel('버튼클릭',self)
        self.lbl1.move(10, 10) # 위젯 위치 조정
        self.lbl1.resize(250,30)

        # 버튼 추가
        self.btn1 = QPushButton('Click', self)
        self.btn1.move(10,40)
        self.btn1.clicked.connect(self.btn1click)   # 버튼 클릭 시그널(이벤트를 이렇게 부른대 !!) 함수 연결

        # 윈도우 바탕화면 정중앙에 위치시키기 !!
        qr = self.frameGeometry()          
        cp = QDesktopWidget().availableGeometry().center()
        qr.moveCenter(cp)
        self.move(qr.topLeft())

        self.show() 
    
    def btn1click(self):
        self.lbl1.setText('버튼을 눌러봐 !')
        QMessageBox.about(self, '알림', '버튼을 클릭했다 !')

if __name__=='__main__' : # 메인모듈이라면
    app = QApplication(sys.argv)
    win = DevWindow()                 
    app.exec_()  