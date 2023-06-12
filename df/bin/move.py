"""Moves shi"""
from time import sleep
import random
from datetime import datetime
import pyautogui

file = open('hist-move.log', 'a', encoding='utf-8')

def main():
    """Main function"""
    random.seed()
    max_width = pyautogui.size().width - 200
    max_height = pyautogui.size().height - 200
    while True:
        # Generate rand numbers
        x = random.randint(200, max_width)
        y = random.randint(200, max_height)
        s = random.randint(60, 120)

        # Format and write output
        tm = datetime.now().strftime('%m-%d-%y %H:%M:%S')
        out_str = f'{tm} | {s:3d}s | ({x}, {y})'
        print(out_str)
        file.write(out_str + '\n')

        # Perform actions
        pyautogui.moveTo(x, y, duration=0.5)
        sleep(s)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print("Exiting...")
        file.close()
