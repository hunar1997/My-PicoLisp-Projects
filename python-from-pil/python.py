import re

def line_split(line):
        return re.findall(r'[^"\s]\S*|".+?"', line) # magic from the internet

def to_lisp(L,initial="'"):
    tp = type(L)
    if tp==list:
        return initial + "(" + " ".join([to_lisp(i,"") for i in L]) + ")"
    elif tp==str:
        return "\"" + L + "\""
    elif tp==float and "e" in str(L):
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
    params = ', '.join(code[1:]).replace("'","")
    res = eval( f"{code[0]}({params})" )
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
    dots = dots.replace("(","[").replace(")","]").replace("'","")
    params = ", ".join(line_split(code[end+1:])).replace("'","")
    res = eval(f"{dots}({params})")
    print( to_lisp(res) )
