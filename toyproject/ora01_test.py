# Oracle 콘솔 연동 예제

# 모듈 설치
# pip install cx_Oracle 
import cx_Oracle as oci

# DB연결 설정변수 선언
sid = 'XE'
host = '127.0.0.1' # = localhost와 동일
# ex) DB서버가 외부에 있다면 ; oracle.pknuprd.net(오라클 서버 주소 적기) or 211.12.119.45(아이피 서버주소 적기)
port = 1521
username = 'madang'
password = 'madang'

# DB연결 시작
conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
    # 커서가 반드시 필요!! ; 만들어줌
cursor = conn.cursor() # DB커서와 동일한 역할을 하는 개체

query = 'SELECT * FROM Students' # 파이썬에서 쿼리 호출 시엔 ;(세미콜론) 삭제 !!
cursor.execute(query)  # 위의 쿼리를 실행해줌

# 불러온 데이터 처리
for i, item in enumerate(cursor, start=1):
    print(item)

cursor.close()
conn.close()
# DB는 연결하면 마지막 close(), 파일은 오픈하면 마지막에 닫아줘야 함!!(꼭 연결을 끊어주자~ : 안 닫으면 다른 사람들이 못 쓴대!!)