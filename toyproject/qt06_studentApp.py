## 20250320 - 20250321까지의 과정 !!
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
basic_msg = '학생정보 v1.0'

class MainWindow(QMainWindow): 
    def __init__(self):       
        super(MainWindow,self).__init__()
        self.initUI()
        self.loadData()

    def initUI(self):
        uic.loadUi('./toyproject/studentdb.ui', self)
        self.setWindowTitle('학생정보앱')
        self.setWindowIcon(QIcon('./image/students.png'))

        # 상태바에 메세지 추가
        self.statusbar.showMessage(basic_msg)


        # 버튼에 아이콘 추가
        self.btn_add.setIcon(QIcon('./image/add-user.png'))
        self.btn_mod.setIcon(QIcon('./image/edit-user.png'))
        self.btn_del.setIcon(QIcon('./image/del-user.png'))
    
    # 버튼 시그널(이벤트) 추가
        self.btn_add.clicked.connect(self.btnAddClick)
        self.btn_mod.clicked.connect(self.btnModClick)
        self.btn_del.clicked.connect(self.btnDelClick)
        # 테이블위젯 더블클릭 시그널 추가
        self.tblStudent.doubleClicked.connect(self.tblStudentDoubleClick)
        self.show()
        ### 함수를 만들면 반드시 함수선언을 할 것!!!
    

    # 화면의 인풋위젯 데이터 초기화함수
    def clearInput(self):
        self.input_std_id.clear()
        self.input_std_name.clear()
        self.input_std_mobile.clear()
        self.input_std_regyear.clear()

    # 테이블위젯 더블클릭 시그널처리 함수 !
    def tblStudentDoubleClick(self):
        # QMessageBox.about(self, '더블클릭', '동작합니다!')
        selected = self.tblStudent.currentRow()  # 현재 선택된 row의 index를 반환하는 함수 !!
        std_id = self.tblStudent.item(selected, 0).text()
        std_name = self.tblStudent.item(selected, 1).text()
        std_mobile = self.tblStudent.item(selected, 2).text()
        std_regyear  = self.tblStudent.item(selected, 3).text()
        # QMessageBox.about(self, '더블클릭', str(selected))
        # QMessageBox.about(self, '더블클릭', f'{std_id}, {std_name}, {std_mobile}, {std_regyear}') : 더이상 나올필요가 없대~

        self.input_std_id.setText(std_id)
        self.input_std_name.setText(std_name)
        self.input_std_mobile.setText(std_mobile)
        self.input_std_regyear.setText(std_regyear)

        # 상태바에 메세지 추가
        self.statusbar.showMessage(f'{basic_msg} | 수정모드')

    
    # 추가버튼 클릭 시그널처리 함수
    def btnAddClick(self):
        #print('추가버튼 클릭')
        std_id = self.input_std_id.text()
        std_name = self.input_std_name.text()      # 여기서만 쓰는 로컬변수 !!
        std_mobile = self.input_std_mobile.text()
        std_regyear = self.input_std_regyear.text()
        print(std_name, std_mobile, std_regyear)


         ## 데이터를 쓰지 않았을 때 사용자를 거부할 수 있는 기능이 바로 데이터 검증 !!
        # 입력 검증 필수(Validation Check)  ; 반드시 해줘야 할 것 !!
        if std_name == '' or std_regyear == '':
            QMessageBox.warning(self,'경고', '학생이름 또는 입학년도를 반드시 입력해 주세요 !')
            return    # 함수를 탈출해주기 위해서 !!
        elif std_id != '':
            QMessageBox.warning(self, '경고', '기학생정보를 다시 등록할 수 없습니다.')
        else:
            print('DB 입력을 진행합니다.')
            values = (std_name, std_mobile, std_regyear) # 변수값 3개를 튜플변수로 담고
            # self.addData(values)                       # 튜플을 파라미터로 전달
            if self.addData(values) == True:
                QMessageBox.about(self, '저장 성공', '학생정보 등록 성공!')
            else:
                QMessageBox.about(self, '저장 실패', '관리자에게 문의하세요.')

            self.loadData()    # 다시 테이블위젯 데이터를 DB에서 조회
            self.clearInput()  # 인풋값 삭제 함수 호출 !

            # 상태바에 메세지 추가
            self.statusbar.showMessage(f'{basic_msg} | 저장 완료')
    
    # 수정버튼 클릭 시그널처리 함수
    def btnModClick(self):
        #print('수정버튼 클릭')
        std_id = self.input_std_id.text()
        std_name = self.input_std_name.text()
        std_mobile = self.input_std_mobile.text()
        std_regyear = self.input_std_regyear.text()
        #print(std_name, std_mobile, std_regyear)

        if std_id == '' or std_name == '' or std_regyear == '':
            QMessageBox.warning(self, '경고','학생번호, 학생이름 또는 입학년도는 필수입니다 !')
            return         # 함수를 탈출!!!!!! (위기탈출 넘버원.)
        else:
            print('DB 수정을 진행합니다.')
            values = (std_name, std_mobile, std_regyear, std_id) # 아이디를 왜 뒤로 넘겼을까? : query에서 가져올때의 순서를 지킨거야~

            if self.modData(values) == True:
                QMessageBox.about(self, '수정 성공', '학생정보 수정 성공!')
            else:
                QMessageBox.about(self, '수정 실패', '관리자에게 문의하세요.')
            
            # 수정 후 바로 로드!!
            self.loadData()
            self.clearInput()

            # 상태바에 메세지 추가
            self.statusbar.showMessage(f'{basic_msg} | 수정 완료')


    def btnDelClick(self):
        #print('삭제버튼 클릭')
        std_id = self.input_std_id.text()
        if std_id == '':
            QMessageBox.warning(self,'경고', '학생번호를 반드시 입력해 주세요 !')
            return    # 함수를 탈출해주기 위해서 !!
        else:
            print('DB 삭제를 진행합니다.')

            # Oracle은 파라미터 타입에 아주 민감함 !! 정확한 타입을 사용해야 해~
            values = (int(std_id), ) # 튜플로 전달, std_id 문자열에서 숫자로 변경
            if self.delData(values) == True:
                QMessageBox.about(self, '삭제 성공', '학생정보 삭제 성공!')
            else:
                QMessageBox.about(self, '삭제 실패', '관리자에게 문의하세요.')

            self.loadData() 
            self.clearInput()

            # 상태바에 메세지 추가
            self.statusbar.showMessage(f'{basic_msg} | 삭제 완료')


    # 테이블 위젯 데이터와 연관해서 화면 설정 !!
    # 원하는 단어에 드래그 후 f12누르면 그 다음 단어로 이동 !!!!! 대박박이!!!! 
    def makeTable(self, lst_student):
        self.tblStudent.setSelectionMode(QAbstractItemView.SingleSelection) # 단일row 선택모드
        self.tblStudent.setEditTriggers(QAbstractItemView.NoEditTriggers) #컬럼수정금지모드
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
        isSucceed = False # 성공여부 플래그 변수
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
            isSucceed = True # 트랜젝션 성공!! ^_^!!
            #return True     # DB 입력 성공 !!
        except Exception as e:
            print(e)
            conn.rollback()   # DB rollback 동일기능 !!
            isSucceed = False # 트랜잭션 실패!! -_- ; finally에는 isSucced = False 쓰지 말자~
            
        finally:
            cursor.close()
            conn.close()
        
        # 줄맞춤에 항상 주의하자 !!!!
        return isSucceed      # 트랜잭션 여부를 리턴
    
    # U(Update)
    def modData(self, tuples):
        isSucceed = False
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin()  

            # 쿼리 만들기   -- addData에서 쿼리만 바꾸면 됨 !!
            query = '''
                    UPDATE MADANG.STUDENTS
	                    SET STD_NAME = :v_std_name
		                , STD_MOBILE = :v_std_mobile
		                , STD_REGYEAR =  :v_std_regyear
	                    WHERE STD_ID= :v_std_id
                    '''
            cursor.execute(query, tuples)  

            conn.commit()  
            isSucceed = True 
        except Exception as e:
            print(e)
            conn.rollback()  
            isSucceed = False 
            
        finally:
            cursor.close()
            conn.close()
    
        return isSucceed
    
    # D(Delete)
    def delData(self, tuples):
        isSucceed = False
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin()  

            # 쿼리 만들기   -- addData에서 쿼리만 바꾸면 됨 !!
            query = '''
                   DELETE FROM students WHERE std_id = :v_std_id
                    '''
            cursor.execute(query, tuples)  

            conn.commit()  
            isSucceed = True 
        except Exception as e:
            print(e)
            conn.rollback()  
            isSucceed = False 
            
        finally:
            cursor.close()
            conn.close()
    
        return isSucceed

       
if __name__=='__main__':
    app = QApplication(sys.argv)
    win = MainWindow()                 
    app.exec_()

## 비주얼 스튜디오에서 Ctrl + f5로 터미널을 출력했을 때, 다시 한 번 실행하려면 조그만 창의 정지 버튼을 누르고
  # 완전히 창을 종료한 후 다시 실행시키자!!!