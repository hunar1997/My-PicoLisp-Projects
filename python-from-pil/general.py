import re

def line_split(line):
        return re.findall(r'[^"\s]\S*|".+?"', line) # magic from the internet

code = input()[1:-1]
if code[0]!="'":
    code=code.split()
    print(eval(( f"{code[0]}({', '.join(code[1:]) })" )))
else:
    end=code.find(')')
    dots = ".".join(line_split(code[2:end]))
    params = ", ".join(line_split(code[end+1:]))
    print(eval(f"{dots}({params})"))


