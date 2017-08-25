import pyautogui
import time
import random

time.sleep(5)
im = pyautogui.screenshot(region=(560, 220, 360, 360))


def dangerCheck(x, y):
    danger = pyautogui.pixelMatchesColor(x, y, (161, 116, 56), tolerance=10)
    return danger


# danger color is (161,116,56)
dangerX = [650, 765]
dangerY = [360, 410]
interval = random.uniform(0.1, 0.15)
dangerLeft = False
dangerRight = False
while True:
    dangerLeft = dangerCheck(dangerX[0], dangerY[0]) or dangerCheck(dangerX[0], dangerY[1])
    dangerRight = dangerCheck(dangerX[1], dangerY[0]) or dangerCheck(dangerX[1], dangerY[1])
    if dangerLeft is False:
        pyautogui.press('left', interval=interval)
    else:
        pyautogui.press('right', interval=interval)










