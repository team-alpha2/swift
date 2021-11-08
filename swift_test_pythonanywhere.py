from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver import ActionChains as Action
from selenium.webdriver.common.by import By
import time

def test_pyaw_address():

   #Test of web address
   browser = webdriver.Chrome()
   browser.get("https://cstacey5.pythonanywhere.com")
   time.sleep(2)

if __name__ == "__main__":
   test_pyaw_address()

def test_pyaw_add():

   #Test of add task
   browser = webdriver.Chrome()
   browser.get("https://cstacey5.pythonanywhere.com")
   input_today_element = browser.find_element(By.ID,'input-today')
   input_today_element.clear
   input_today_element.send_keys("test task")
   time.sleep(2)
   button_save = browser.find_element(By.ID,'save_edit-today')
   button_save.click()
   time.sleep(2)

if __name__ == "__main__":
   test_pyaw_add()
   
#def test_pyaw_delete():   
   #Test of delete existing task



