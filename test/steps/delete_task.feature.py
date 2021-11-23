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
tasks = browser.find_elements_by_class_name("delete_task")
count = len(tasks)

tasks[0].click()

try:
    tasks = browser.find_elements_by_class_name("delete_task")
    assert(len(tasks) < count)
    print("Successfully deleted task!")
except: 
    print("No tasks were deleted!")