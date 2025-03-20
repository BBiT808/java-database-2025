# Oracle Student앱
# CRUD 데이터베이스 : DML(SELECT, INSERT, UPDATE, DELETE)
## CREATE(INSERT), REQUEST(SELECT), UPDATE(UPDATE), DELETE(DELETE)

   ## CRU 개발해!! 하면 DELETE는 없는거야!! 기억하자 ~~
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5 import QtGui, QtWidgets, uic

# Oracle 모듈 
import cx_Oracle as oci

# DB 연결 설정
sid = 'XE'
host = 'localhost'
port = 1521
username = 'madang'
password = 'madang'

class MainWindow(QMainWindow): 
    def __init__(self):       
        super(MainWindow,self).__init__()
        self.initUI()
        self.loadData()

    def initUI(self):
        uic.loadUi('./toyproject/studentdb.ui', self)
        self.setWindowTitle('학생정보앱')
        self.setWindowIcon(QIcon('./image/database.png'))

    def initUI(self):
        uic.loadUi('./toyproject/Studentdb.ui', self)
        self.show()
    
    # 버튼 이벤트 추가
        self.btn_add.clicked.connect(self.btnAddClick)
        self.btn_mod.clicked.connect(self.btnModClick)
        self.btn_del.clicked.connect(self.btnDelClick)
        self.show()
        ## 함수를 만들면 반드시 함수선언을 할 것!!!
    
    def btnAddClick(self):
        #print('추가버튼 클릭')
        std_name = self.input_std_name.text() # 여기서만 쓰는 로컬변수 !!
        std_mobile = self.input_std_mobile.text()
        std_regyear = self.input_std_regyear.text()
        print(std_name, std_mobile, std_regyear)


        ## 데이터를 쓰지 않았을 때 사용자를 거부할 수 있는 기능이 바로 데이터 검증 !!
        # 입력 검증 필수(Validation Check)  ; 반드시 해줘야 할 것 !!
        if std_name == '' or std_regyear == '':
            QMessageBox.warning(self,'경고', '학생이름 또는 입학년도를 반드시 입력해 주세요 !')
            return    # 함수를 탈출해주기 위해서 !!
        else:
            print('DB 입력을 진행합니다.')
            values = (std_name, std_mobile, std_regyear) # 변수값 3개를 튜플변수로 담고
            self.addData(values)  # 튜플을 파라미터로 전달
    

    def btnModClick(self):
        print('수정버튼 클릭')

    def btnDelClick(self):
        print('삭제버튼 클릭')

    # 테이블 위젯 데이터와 연관해서 화면 설정 !!
    # 원하는 단어에 드래그 후 f12누르면 그 다음 단어로 이동 !!!!! 대박박이!!!! 
    def makeTable(self, lst_student):
        self.tblStudent.setColumnCount(4)
        self.tblStudent.setRowCount(len(lst_student))  # 커서에 들어있는 데이터의 길이만큼 row 생성 !!
        self.tblStudent.setHorizontalHeaderLabels(['학생번호','학생이름','핸드폰','입학년도'])

        # 전달받은 cursor를 반복문(for문)으로 테이블위젯에 적용하는 작업
        i = 0
        for i, (std_id, std_name, std_mobile, std_regyear) in enumerate(lst_student):
            self.tblStudent.setItem(i,0,QTableWidgetItem(str(std_id)))   # oracle number타입은 뿌릴 때 str()로 형변환이 필요하다!!
            self.tblStudent.setItem(i,1,QTableWidgetItem(std_name))
            self.tblStudent.setItem(i,2,QTableWidgetItem(std_mobile))
            self.tblStudent.setItem(i,3,QTableWidgetItem(str(std_regyear)))
            i+=1

            # 선생님 방법 (꼼수래요~)
        #for _, (std_id, std_name, std_mobile, std_regyear) in enumerate(cursor, start=1):
            #self.tblStudent.setItem(i,0,QTableWidgetItem(str(std_id)))   # oracle number타입은 뿌릴 때 str()로 형변환이 필요하다!!
            #self.tblStudent.setItem(i,1,QTableWidgetItem(std_name))
            #self.tblStudent.setItem(i,2,QTableWidgetItem(std_mobile))
            #self.tblStudent.setItem(i,3,QTableWidgetItem(str(std_regyear)))
            #i+=1

    # R(SELECT)
    def loadData(self):
        # DB연결
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        query = '''SELECT std_id, std_name
	                    , std_mobile, std_regyear
                    FROM Students'''
        cursor.execute(query)

        #for i, (std_id, std_name, std_mobile, std_regyear) in enumerate(cursor, start=1):
        #    print(std_id, std_name, std_mobile, std_regyear)
        lst_student = []  # 리스트 생성
        for _, item in enumerate(cursor):
            lst_student.append(item)

        self.makeTable(lst_student) # 새로 생성한 리스트를 파라미터로 전달

        cursor.close()
        conn.close()

    # C(INSERT)
    def addData(self, tuples):
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin()   # BEGIN TRANSACTION : 트랜잭션 시작

            # 쿼리 만들기
            query = '''
                    INSERT INTO MADANG.STUDENTS (std_id, std_name, std_mobile, std_regyear)
                    VALUES (SEQ_STUDENT.NEXTVAL,:v_std_name,:v_std_mobile, :v_std_regyear)
                    '''
            cursor.execute(query, tuples)   # query에 들어가는 동적변수 3개는 뒤의 tuples가 순서대로 맵핑시켜 준다 !!

            conn.commit()   # DB commit과 동일기능이래 ~
            last_id = cursor.lastrowid  # SEQ_STUDENT.CURRVAL
            print(last_id)
            #return True # DB 입력 성공 !!
        except Exception as e:
            print(e)
            conn.rollback()   # DB rollback 동일기능 !!
            
        finally:
            cursor.close()
            conn.close()

       
if __name__=='__main__':
    app = QApplication(sys.argv)
    win = MainWindow()                 
    app.exec_()