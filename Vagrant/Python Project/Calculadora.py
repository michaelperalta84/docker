import tkinter as tk
import math

# Funciones científicas
def click(event):
    global expression
    text = event.widget.cget("text")
    if text == "=":
        try:
            result = str(eval(expression))
            entry_var.set(result)
            expression = result
        except Exception as e:
            entry_var.set("Error")
            expression = ""
    elif text == "C":
        expression = ""
        entry_var.set("")
    elif text == "√":
        try:
            result = str(math.sqrt(eval(expression)))
            entry_var.set(result)
            expression = result
        except:
            entry_var.set("Error")
            expression = ""
    elif text == "sin":
        try:
            result = str(math.sin(math.radians(eval(expression))))
            entry_var.set(result)
            expression = result
        except:
            entry_var.set("Error")
            expression = ""
    elif text == "cos":
        try:
            result = str(math.cos(math.radians(eval(expression))))
            entry_var.set(result)
            expression = result
        except:
            entry_var.set("Error")
            expression = ""
    elif text == "tan":
        try:
            result = str(math.tan(math.radians(eval(expression))))
            entry_var.set(result)
            expression = result
        except:
            entry_var.set("Error")
            expression = ""
    elif text == "log":
        try:
            result = str(math.log10(eval(expression)))
            entry_var.set(result)
            expression = result
        except:
            entry_var.set("Error")
            expression = ""
    elif text == "ln":
        try:
            result = str(math.log(eval(expression)))
            entry_var.set(result)
            expression = result
        except:
            entry_var.set("Error")
            expression = ""
    elif text == "π":
        expression += str(math.pi)
        entry_var.set(expression)
    elif text == "e":
        expression += str(math.e)
        entry_var.set(expression)
    else:
        expression += text
        entry_var.set(expression)

# Ventana principal
root = tk.Tk()
root.title("Calculadora Científica")

# Variables
expression = ""
entry_var = tk.StringVar()

# Entrada
entry = tk.Entry(root, textvar=entry_var, font="Arial 20", bd=10, relief=tk.RIDGE, justify='right')
entry.pack(fill=tk.BOTH, ipadx=8)

# Botones
buttons = [
    ["7", "8", "9", "/", "C"],
    ["4", "5", "6", "*", "√"],
    ["1", "2", "3", "-", "+"],
    ["0", ".", "=", "(", ")"],
    ["sin", "cos", "tan", "log", "ln"],
    ["π", "e", "**", "//", "%"]
]

for row in buttons:
    frame = tk.Frame(root)
    frame.pack(expand=True, fill="both")
    for btn_text in row:
        button = tk.Button(frame, text=btn_text, font="Arial 18", relief=tk.RAISED, bd=4)
        button.pack(side="left", expand=True, fill="both")
        button.bind("<Button-1>", click)

root.mainloop()
