import re

def line_split(line):
        return re.findall(r'[^"\s]\S*|".+?"', line) # magic from the internet

def to_lisp(L,initial="'"):
    if type(L)==list:
        return initial + "(" + " ".join([to_lisp(i,"") for i in L]) + ")"
    elif type(L)==str:
        return "\"" + L + "\""
    elif type(L)==float and "e" in str(L):
        s = str(L)
        e = s.find("e")
        a = s[:e].replace(".","")
        b = int(s[e+1:])
        if b>0:
            return a.ljust(2*b-len(a), "0")
        else:

            return "0." + a[2:].rjust(len(a)+abs(b)-3,"0")
    else:
        return L

code = input()[1:-1]
if code[0]!="'":
    code=code.replace("(","[").replace(")","]").replace(".","'.'").split()
    removes=[]
    for i,v in enumerate(code):
        if v=="'.'":
            a = int(code[i-1][1:])
            b = int(code[i+1][:-1])
            code[i-1]=str(a/b)
            removes.append(i)
            removes.append(i+1)
    removes.reverse()
    for v in removes:
        code.pop(v)
    res = eval( f"{code[0]}({', '.join(code[1:]) })" )
    print( to_lisp(res) )
else:
    end=0
    for i,v in enumerate(code):
        if v=="(": end+=1
        if v==")": end-=1
        if i>1 and end==0:
            end=i
            break
        if v==" " and end>1:
            code = code[:i]+","+code[i+1:]
    
    dots = ".".join(line_split(code[2:end]))
    dots = dots.replace("(","[").replace(")","]")
    params = ", ".join(line_split(code[end+1:]))
    res = eval(f"{dots}({params})")
    print( to_lisp(res) )
