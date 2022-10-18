import re

def line_split(line):
        return re.findall(r'[^"\s]\S*|".+?"', line) # magic from the internet

def to_lisp(L,initial="'"):
    if type(L)==list:
        return initial + "(" + " ".join([to_lisp(i,"") for i in L]) + ")"
    elif type(L)==str:
        return "\"" + L + "\""
    else:
        return L
    # todo: integer is fine, but float maybe scientific noation

def from_lisp(L):
    return L

code = input()[1:-1]
if code[0]!="'":
    code=code.split()
    print(eval( f"{code[0]}({', '.join(code[1:]) })" ))
else:
    end=code.find(')')
    dots = ".".join(line_split(code[2:end]))
    params = ", ".join(line_split(code[end+1:]))
    res = eval(f"{from_lisp(dots)}({from_lisp(params)})")
    print( to_lisp(res) )


