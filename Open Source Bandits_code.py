import sys
import PyQt5
from PyQt5.QtWidgets import *
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QLineEdit, QTextEdit
from PyQt5.QtCore import Qt
import mysql.connector
import time


class ChatbotGUI(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()
        self.state=0
        self.details=[]

    def initUI(self):
        self.setWindowTitle('Endal')
        self.setGeometry(100, 100, 600, 400)
        #self.setStyleSheet("QMenuBar { background-color: darkslateblue; color: white; }")
        self.setStyleSheet("background-color: lavender;")

        # Create a text area for displaying chat history
        self.chat_history = QTextEdit(self)
        self.chat_history.setReadOnly(True)

        # Create an input field for user messages
        self.input_field = QLineEdit(self)
        self.input_field.returnPressed.connect(self.send_message)

        # Create a Send button to send messages
        self.send_button = QPushButton('Send', self)
        self.send_button.clicked.connect(self.send_message)

        # Layout setup
        vbox = QGridLayout()
        vbox.addWidget(self.chat_history)
        vbox.addWidget(self.input_field)
        vbox.addWidget(self.send_button)

        self.setLayout(vbox)

        self.append_message("Endal:","Hello! I am Endal! I am here to assist you today!")
        #self.append_message("Endal:","Please enter your hospital ID")
        #user_msg=self.input_field.text()
        #self.check_user(user_msg)
        self.append_message("Endal:","Please enter your hospital ID")

    def send_message(self):
        
        user_message = self.input_field.text()
        self.input_field.clear()
        # Append the user's message to the chat history
        self.append_message("You:", user_message)
        #self.check_user(user_message)

        # Implement your chatbot logic here and get the chatbot's response
        chatbot_response,valid = self.get_chatbot_response(user_message)

        # Append the chatbot's response to the chat history
        self.append_message("Endal:", chatbot_response)
        if valid:
            self.state+=1
        self.ask_next()
            #self.details.append(user_message)

    def append_message(self, sender, message):
        # Append a message to the chat history
        self.chat_history.append(f"<b>{sender}</b>: {message}")

    def get_chatbot_response(self, user_message):
        # Implement your chatbot logic here to generate a response
        
        if self.state==0:
            response,valid=self.check_user(user_message)
            return response,valid
        if self.state==1:
            valid=True
            response="Okay,I see"
            return response,valid
        if self.state==2:
            response,valid=self.check_error(user_message)
            #self.append_message("Endal:","Please wait while I check for further details")
            #time.sleep(3)
            return response,valid
        if self.state==3:
            response,valid=self.ask_user(user_message)
            return response,valid
        if self.state==4:
            response,valid=self.confirmation(user_message)
            return response,valid
        if self.state==5:
            response,valid=self.check_solution()
            return response,valid


        
    
    def check_user(self,user_msg):
        if user_msg.isdigit():
            user_id=int(user_msg)
            mydb = mysql.connector.connect(
                    host="localhost",
                    user="root",
                    password="pes2ug20cs334",
                    database="ge_hackathon"
                    )
            mycursor=mydb.cursor()
            query="SELECT h.hospital_name as NAME,m.asset_id as ASSET_ID,m.machine_name as MACHINE from hospital h JOIN machine_info m on h.hospital_id=m.hospital_id where h.hospital_id=%s"
            mycursor.execute(query,(user_id,))
            records=mycursor.fetchall()
            if records:
                query="SELECT asset_id FROM machine_info WHERE hospital_id=%s"
                mycursor.execute(query,(user_id,))
                machine=mycursor.fetchall()
                self.details.append(user_msg)
                #self.details.append(machine)
                return records,True
            else:
                return "ID not found!",False
        else:
            return "Please enter valid ID",False

    def check_error(self,user_message):
        mydb = mysql.connector.connect(
                    host="localhost",
                    user="root",
                    password="pes2ug20cs334",
                    database="ge_hackathon"
                    )
        mycursor=mydb.cursor()
        query="SELECT * FROM error_codes_solutions WHERE error_code=%s"
        mycursor.execute(query,(user_message,))
        records=mycursor.fetchone() 
        if records is not None:
            query="SELECT error_id FROM error_codes_solutions WHERE error_code=%s"
            mycursor.execute(query,(user_message,))
            info=mycursor.fetchone()
            self.check_if_problem_has_occured(info)
            query="SELECT fix_by FROM error_codes_solutions WHERE error_code=%s"
            mycursor.execute(query,(user_message,))
            info=mycursor.fetchone()
            if info[0]=="Service Executive":
                self.state=8
                return "Will raise a service request, Will update you",False
            #query="SELECT error_id FROM error_codes_solutions WHERE error_code=%s"
            #mycursor.execute(query,(user_message,))
            #info=mycursor.fetchone()
            #self.check_if_problem_has_occured(info)
            self.details.append(user_message)
            return "Checking for further details",True
            
        else:
            self.state=7
            return "Will raise a service request, Will update you",True

    def check_solution(self):
         mydb = mysql.connector.connect(
                     host="localhost",
                     user="root",
                     password="pes2ug20cs334",
                     database="ge_hackathon"
                     )
         mycursor=mydb.cursor()
         query="SELECT fix_by FROM error_codes_solutions WHERE error_code=%s"
         mycursor.execute(query,(self.details[1],))
         info=mycursor.fetchone()
         if info=="Service Executive":
             self.state=7
             return "Will raise a service request, Will update you",True
         query="SELECT solution_details FROM error_codes_solutions WHERE error_code=%s"
         mycursor.execute(query,(self.details[1],))
         solution=mycursor.fetchone()
         self.append_message("Endal:","The steps to solve are:")
         return solution,True

    def check_if_problem_has_occured(self,info):
        mydb = mysql.connector.connect(
                    host="localhost",
                    user="root",
                    password="pes2ug20cs334",
                    database="ge_hackathon"
                    )
        mycursor=mydb.cursor()
        hosp_id=self.details[0]
        info=int(info[0])
        query="SELECT * FROM problem_history_db WHERE hospital_id=%s AND error_id=%s"
        mycursor.execute(query,(hosp_id,info,))
        record=mycursor.fetchone()
        if record is not None:
            self.append_message("Endal:","This problem has occured before. These are the details:")
            self.append_message("Endal:",record)
        else:
            self.append_message("Endal:","Looks like this problem has not occured before")

    def ask_user(self,user_message):
        #self.append_message("Endal:","You can solve this issue by yourself. Do you want to go ahead?(Y/N)")
        #user_message = self.input_field.text()
        #self.input_field.clear()
        # Append the user's message to the chat history
        #self.append_message("You:", user_message)
        user_message.lower()
        if user_message=="y" or user_message=="yes":
            self.state=5
            return "Okay",False
        else:
            self.state=4
            return "Okay",False

    def confirmation(self,user_message):
        user_message.lower()
        if user_message=="y" or user_message=="yes":
            self.state=5
            return "Okay",False
        else:
            self.state=7
            return "Will raise a service request, Will update you",True




    def ask_next(self):
        if self.state==1:
            self.append_message("Endal:","What issue are you facing?")
        if self.state==2:
            self.append_message("Endal:","What error code is being displayed?")
        if self.state==3:
            self.append_message("Endal:","You can solve this issue by yourself. Do you want to go ahead?(Y/N)")
        if self.state==4:
            self.append_message("Endal:","Are you sure? You can save time and money by resolving by yourself!")
            self.append_message("Endal:","You can solve this issue by yourself. Do you want to go ahead?(Y/N)")
        if self.state==5:
            self.append_message("Endal:","Please enter any letter for your confirmation to proceed to the solution")
            #self.append_message("Endal:","The steps to solve are:")
        if self.state==6:
            self.append_message("Endal:","Glad I was able to help!")
        if self.state==8:
            self.append_message("Endal:","Thank you have a great day!")

if __name__ == '__main__':
    app = QApplication(sys.argv)
    chatbot_window = ChatbotGUI()
    chatbot_window.show()
    sys.exit(app.exec_())