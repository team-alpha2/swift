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
taskId = "1"
task = browser.find_element_by_id("description-" + taskId)
task.click()
tasks = browser.find_elements_by_class_name("completed")

try:
    assert(len(tasks) > 1)
    print("Successfully completed task!")
except: 
    print("No tasks were completed!")
