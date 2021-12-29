if exists("b:current_syntax")
   finish
endif

" Put this file in    ~/.vim/syntax/l.vim
" Currently you have to open a file and  :set syntax=l  to activate it
" To do it automatically, make this file   ~/.vim/ftdetect/l.vim
" and write this inside    autocmd BufRead,BufNewFile *.l set filetype=l
" It highlits strings,comments, and all the symbols in (all)
" except  | \ . ^   because I couldn't figure out how

syntax iskeyword @,48-57,192-255,_,*,/,!,%,$,&,+,-,:,;,<,=,>,?,@-@

syn keyword functions ! $ % & * + - / : ; < = > ? @ A B C 
         \ D F H I K L M N O P Q R S T U V W X Y Z ^ _ d e 
         \ t u v  \~ ** ++ .. */ =0 n0 =1 V1 X1 V2 X2 :: 
         \ =: <= == >= -> <> >> %@ @@ @A @B @C @D @F @H @I 
         \ @L @M @N @P @Q @R @S =T nT @V @X @Y @Z db ub gc 
         \ rc cd fd hd id rd be de if vi dm in on To co do 
         \ pp up or pr wr Ms as at bt Ex by x| +-- ge0 le0 
         \ gt0 lt0 Sd2 if2 db: n== sp? @@@ *DB +UB @CL NIL 
         \ *OS isa Tab tab Feb feb job Sub Dec dec inc doc 
         \ loc Src pad Wed led rid Fld Old cmd End and bnd 
         \ upd pwd one use Tue bye Dbf dbf def off eof Buf 
         \ buf bag Beg Flg Prg arg Msg msg Aug aug nth Fri 
         \ Obj obj blk Val val scl Rel del rel nil All all 
         \ eol ssl ctl Jul jul Dim Tim sum Sym sym +Sn Jan 
         \ can jan ifn Min bin fin min Mon con Jun Sun jun 
         \ run who map zap udp Sep dep sep vip tmp Top pop 
         \ nsp dup lup Typ seq Mar Var car mar var adr cdr 
         \ Dir dir Clr for nor xor Apr apr err Str str Cur 
         \ has abs dbs Res mis Cls cls Pos sys Dat Pat Sat 
         \ Oct oct get let set lit Cnt cnt not rot opt Dst 
         \ Lst lst Att cut out put ext Thu rev env Nov nov 
         \ raw New new Max hax max Idx idx hex mix Box box 
         \ Aux aux May day may Key key any try tty inc! set
         \ ! put! new! tim$ dat$ dbs+ +--- hex1 or/2 Old2 
         \ Val2 New2 Aux2 db/3 db/4 db/5 var: ub>= dec> inc
         \ > upd> ele> gui> del> rel> url> zap> has> mis> 
         \ set> put> sub? pre? flg? num? sym? fun? upp? str
         \ ? pat? let? bit? lst? ext? low? box? *CPU zap_ 
         \ meta blob usec exec conc sync proc mapc uppc 
         \ circ lowc head read load need seed *Pid ipid 
         \ opid fold hold @End nand rand send bind find 
         \ cond nond getd once made Node Tree free tree 
         \ make yoke File file name same time line pipe 
         \ wipe type here more Base case lose date byte 
         \ glue true *Bye Size size leaf +Ref diff +Bag *
         \ Dbg @Beg xchg Lang prog *Msg hash fish push 
         \ path meth with *Uni mini maxi @Obj pack dbck 
         \ pick lock peek seek week rank link Hook hook 
         \ Mark mark fork Task task @Val goal eval *Scl 
         \ Excl fail mail tail call tell fill kill till 
         \ poll full *Jnl bool pool getl putl stem trim $
         \ tim From from atom enum llvm qsym scan @Gen 
         \ when open prin *Mon *mon *Run pico fifo info 
         \ echo plio zero *Zap heap wrap swap +Dep beep 
         \ keep step skip clip flip help *Tmp chop loop 
         \ prop lisp *Hup @Typ mmeq uniq delq memq asoq 
         \ casq setq @Var caar cdar hear char subr *Adr 
         \ cadr cddr iter pair tolr expr *Err *Dbs docs 
         \ kids Olds Args args +Mis This @Cls Vals cons 
         \ maps Vars pass less News $dat what sect wait 
         \ init quit +Alt lint slot Root root part Port 
         \ port sort sqrt @Lst last rest test list Host 
         \ host *Ext next text accu lieu argv priv view 
         \ show +Idx +Aux *Day +Key +Any copy rqry Ctry 
         \ ctty blob! blob+ *Sep0 nil/1 not/1 *Sig1 prog1 
         \ push1 isa/2 for/2 +Ref2 *Sig2 prog2 pool2 val/3 
         \ map/3 for/3 lst/3 *Sep3 for/4 dec!> inc!> del!> 
         \ set!> put!> url1> url2> url3> url4> url5> url6> 
         \ url7> url8> url9> rel?> lose> keep> circ? enum? 
         \ EINTR extra *Blob +Blob assoc +Need *PPid yield 
         \ +Fold round place space trace *Once range cache 
         \ while *Rule +Time prune store close +Date state 
         \ quote queue solve prove redef undef onOff *Lang 
         \ pilog debug unbug bench catch match patch fetch 
         \ touch flush depth stack _week +Link +Hook @Hook 
         \ *Fork local equal trail until prinl +Bool alarm 
         \ *Term align chain sigio *Solo errno macro +Swap 
         \ @Step strip stamp group rasoq caaar cdaar cadar 
         \ cddar caadr cdadr caddr cdddr super later chdir 
         \ prior recur rules bytes tasks class shift split 
         \ print count _rcpt nlPrt spPrt abort +List allow 
         \ throw index money unify fully apply query curry 
         \ *Ctry true/0 fail/0 prtty0 call/1 show/1 *TStp1 
         \ nlPrt1 prtty1 uniq/2 +Hook2 *TStp2 prtty2 head/
         \ 3 fold/3 same/3 bool/3 tolr/3 part/3 prtty3 lose
         \ !> keep!> lose1> keep1> keep?> clone> print> 
         \ prtty? EAGAIN EACCES dbSync rassoc append 
         \ extend rewind method locale *Prune clause 
         \ create delete remote native remove detach *
         \ Winch length prEval ubZval idxRel expTel forall 
         \ datSym mapcan listen mapcon daemon intern 
         \ extern ultimo push1q caaaar cdaaar cadaar 
         \ cddaar mapcar caadar cdadar caddar cdddar 
         \ caaadr cdaadr cadadr cddadr caaddr cdaddr 
         \ cadddr cddddr member ubIter filter center 
         \ telStr datStr *Class unless expDat strDat 
         \ repeat format object select struct offset 
         \ commit noLint +Joint accept script insert 
         \ assert *SPort import export *Allow +index 
         \ useKey genKey minKey maxKey pretty equal/2 range
         \ /3 clone!> asserta allowed replace untrace 
         \ Service balance chkTree zapTree dirname acquire 
         \ release reverse recurse private +Remote _remote 
         \ permute revolve +String journal treeRel lintAll 
         \ +Symbol println version printsp ai_addr +Number 
         \ Browser methods sysdefs symbols retract extract 
         \ collect connect protect default *MonFmt *DayFmt 
         \ decECnt incECnt *NoLint *Prompt request maplist 
         \ timeout ai_next ext:Snx finally history +Entity 
         \ _pretty assertz request! asserta/1 permute/2 
         \ revolve/2 retract/1 assertz/1 repeat/0 clause/2 
         \ remote/2 member/2 append/3 delete/3 select/3 
         \ prBase64 AF_INET6 INET6_ADDRSTRLEN AF_UNSPEC 
         \ SO_REUSEADDR SOL_SOCKET IPV6_V6ONLY NI_MAXHOST 
         \ NI_NAMEREQD SOCK_DGRAM SOCK_STREAM IPPROTO_IPV6 
         \ socklen_t download sin6_addr +IdxFold *CtryCode 
         \ genStrKey *NoTrace basename ext:Base64 complete 
         \ _revolve rollback ai_family traceAll ai_addrlen 
         \ sin6_family different different/2 *NatTrunkPrf 
         \ addrinfo +relation sockaddr_in6 initQuery 
         \ sin6_port -symbols @Sockets ai_socktype *DateFmt

syn match pilComment "#.*$"
syntax region pilMultilineComment start=/#{/ end=/}#/
syn region pilString start=+\%(\\\)\@<!"+ skip=+\\[\\"]+ end=+"+

let b:current_syntax = "pil"

hi def link functions Statement
hi def link pilComment Comment
hi def link pilMultilineComment Comment
hi def link pilString String


