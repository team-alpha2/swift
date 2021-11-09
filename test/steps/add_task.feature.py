from behave import *;
from selenium import webdriver;
import sys;
from time import sleep

def createBrowser(name):
    if(name == "chrome"):
        return webdriver.Chrome()
    elif(name == "safari"):
        return webdriver.Safari()
    elif(name == "firefox"):
        return webdriver.Firefox()

global browser

if(len(sys.argv) > 1):
    browserName = sys.argv[1]
    print(browserName)
    browser = createBrowser(browserName)
else:
    browser = createBrowser("chrome")

browser.get("http://localhost:8080")

sleep(1)
browser.execute_script("var input = document.getElementById('input-today');input.focus();input.value='test'")
browser.execute_script("document.getElementById('save_edit-today').click()")
tasks = browser.find_elements_by_class_name("task")

try:
    assert(len(tasks) > 2)
    print("Successfully added task!")
except: 
    print("No tasks were added!")