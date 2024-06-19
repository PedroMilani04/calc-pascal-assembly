unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, Interfaces;

const
  SIZE = 10000;

type // PILHA PARA OS OPERANDOS (chars)
    PCharNode = ^CharNode; // PNode é o ponteiro para um nó
    CharNode = record // Node é um struct com um char e um ponteiro para o próximo nó
        value:char;
        next: PCharNode;
    end;

type // LISTA PARA OS NUMEROS(strings)
    PNode = ^Node;
    Node = record
        data: string;
        next: PNode;
    end;
    StringArray = array of string;
    Queue = record
        front, rear: PNode;
    end;




  { TForm1 }

  TForm1 = class(TForm)
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    Button32: TButton;
    Button33: TButton;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Edit1: TEdit;
    ButtonAdd: TButton;
    ButtonEqual: TButton;
    Button0: TButton;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ButtonSubtract: TButton;
    ButtonMultiply: TButton;
    ButtonDivide: TButton;
    ButtonBackspace: TButton;
    ButtonCE: TButton;
    ButtonC: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure ButtonEqualClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure ButtonBackspaceClick(Sender: TObject);
    procedure ButtonCEClick(Sender: TObject);
    procedure ButtonCClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Expression: string; // expressão
  Radianos: Boolean; // radianos/graus

implementation

{$R *.lfm}
procedure TForm1.FormCreate(Sender: TObject);
begin

end;


// STACK FUNCTIONS =============================================================
// String Stack
procedure pushS(var top:PNode;data:string);
var
    newNode: PNode;
begin
    newNode := new(PNode);
    newNode^.data := data;
    newNode^.next := top;
    top := newNode;
end;
function popS(var top: PNode):string;
var
    temPNode: PNode;
    data:string;
begin
    if top <> nil then
    begin
        data := top^.data;
        temPNode := top;
        top := top^.next;
        dispose(temPNode);
        PopS := data;
    end
    else
    begin

        PopS := '#';  { Return a sentinel value }
    end;
end;

// Char Stack
procedure Push(var top: PCharNode; value: char);
var
    newNode: PCharNode;
begin
    newNode := new(PCharNode);
    newNode^.value := value;
    newNode^.next := top;
    top := newNode;
end;
function Pop(var top: PCharNode): char;
var
    temPCharNode: PCharNode;
    value: char;
begin
    if top <> nil then
    begin
        value := top^.value;
        temPCharNode := top;
        top := top^.next;
        dispose(temPCharNode);
        Pop := value;
    end
    else
    begin

        Pop := '#';  { Return a sentinel value }
    end;
end;
// =============================================================================




// QUEUE FUNCTIONS =============================================================
procedure InitializeQueue(var q: Queue);
begin
    q.front := nil;
    q.rear := nil;
end;
function IsEmpty(var fila: queue): integer;
begin
    if fila.front = nil then
    begin
      IsEmpty := 1;
    end
    else IsEmpty:=0;
end;
procedure Enqueue(var fila:queue;data:string);
var
    newNode:PNode;
begin
    new(newNode);
    newNode^.data := data;
    newNode^.next := nil;

    if IsEmpty(fila)=1 then  // If the queue is empty, set both its end and its start to be the new node
    begin
        fila.front := newNode;
        fila.rear := newNode;
    end
    else    // If the queue is not empty, add the newNode to the end of iit
    begin
        fila.rear^.next := newNode;
        fila.rear := newNode;
    end;

end;
function Dequeue(var fila: Queue): string;
var
    tempNode: PNode;
    data: string;
begin
    if IsEmpty(fila)=1 then // If the queue is empty, return a flag value
    begin

        Dequeue:='empty_queue';
    end
    else
    begin
      tempNode := fila.front;    // Temporary node is the firs node of the queue
      data := tempNode^.data; // Value is the data held by that node
      fila.front := fila.front^.next; // The front of the queue is iterated

      if fila.front = nil then // If the queue had only one element left, set both its start and its end to nil

         fila.rear := nil;

      dispose(tempNode); // Free memory occupied by the previous first node
      Dequeue := data;  // Return the data
    end;
end;
procedure printQueue(fila:queue);
begin

    while(fila.front <> fila.rear) do
    begin
      write(fila.front^.data, '  ');
      fila.front := fila.front^.next;
    end;

end;
// =============================================================================



// INFIX TO PREFIX FUNCTIONS ==================================================        // Falta reconhecimento de função como token e confirmar precedências e associatividade de operadores
// Finding the number in a string
function getNumber(str:string):string;
var
  res:string;
  i:Integer;
  len:Integer;
  pointFound:Integer;
  neg:Boolean;
  start:integer;

begin
  res:=''; pointFound:=0;neg:=False;start:=1;
  len := Length(str);

  if str[1]='~' then
    begin
      neg:=True;
      start:=2;
    end;

  for i := start to len do
  begin

    if (str[i]<>'0') and (str[i]<>'1') and (str[i]<>'2') and (str[i]<>'3') and (str[i]<>'4') and (str[i]<>'5') and (str[i]<>'6') and (str[i]<>'7') and (str[i]<>'8') and (str[i]<>'9') then
    begin

      // If the current char is not a number, check whether it is a point
      if(str[i]='.') then   // If it is a point
      begin
        if pointFound=1 then break             // And has already been found, break.
        else
            begin
              res:=res+str[i]; // If it hasn't already been found, accept it and pointFound=1
              pointFound:=1;
            end;
        // If it is a point, set pointFound to true and append the point to the res string

      end
      else  // If is neither a point nor a number, break res of the loop
        begin

             break;
        end;
    end
    else
        begin
        // If it is a number, append it

        res:=res+str[i];
        end;
  end;

  if neg=True then res:='~'+res;

  getNumber:=res;
end;

function isNumber(str:string):Boolean;
begin

  if(getNumber(str)=str)  then begin isNumber:=True;end
  else isNumber:=False;
end;
function isOperator(str:string):Boolean;
begin
  if (str = '+') or (str = '-') or (str = '/') or (str = '*') or (str = '^') or (str = '~') or (str='!') then begin isOperator:=True;end
  else isOperator:=False;
end;
function isFunction(str:string):Boolean;
begin       // sin cos tan log geral ln l10 sqrt sqrtn:z
  if (str='s') or (str='c') or (str='t') or (str='l') or (str='n') or (str='g') or (str='r') or (str='z') or (str='w') or (str='x') or (str='y') then begin isFunction:=True; end
  else isFunction:=False;
end;
function isConstant(s:string):Boolean;
begin
  if (s = 'p') or (s = 'e') then begin isConstant:=True; end
  else isConstant:=False;

end;

function replaceConstant(s:string):string;
begin
  case s of
    'p':replaceConstant:='3.141592653589793238462643383279502884197';
    'e':replaceConstant:='2.7182818284590452353602874713527';
  end;
end;

// Getting the tokens out of an expression
function getAtoms(inputStr:string):stringArray;
var
  len:integer;
  i:integer;
  atoms:stringArray;
  number:string;
  op: char;
  neg:boolean;
  negStr:string;

  str2:string;
  str3:string;
  str4:string;
  str5:string;
  str6:string;
begin
  neg:=False;negStr:='-';
  SetLength(atoms, 100000);

  // Create an array of strings, where the strings are either numbers or operators
  i:=1;
  while length(inputStr) > 0 do // While we haven't reached the end of the string
  begin

    while(inputStr[1]=' ') do Delete(inputStr, 1,1);

    if (inputStr[1]<>'0') and (inputStr[1]<>'1') and (inputStr[1]<>'2') and (inputStr[1]<>'3') and (inputStr[1]<>'4') and (inputStr[1]<>'5') and (inputStr[1]<>'6') and (inputStr[1]<>'7') and (inputStr[1]<>'8') and (inputStr[1]<>'9') and (inputStr[1]<>'~') then
    begin // If it is not a number

      // If it is a minus sign, the next number will be negative
      if inputStr[1]='~' then neg:=True;




      // If it is an operator
      if isOperator(inputStr[1]) or (inputStr[1] = '(') or (inputStr[1] = ')') then
      begin
        op := inputStr[1];
        Delete(inputStr, 1, 1);
        atoms[i]:=op;
        Inc(i);
      end
      else    // Otherwise, it has to be either a constant or a function
      begin

        if(inputStr[1]='e') then
        begin
          Delete(inputStr, 1,1);
          atoms[i]:='e'; Inc(i);
        end
        else
        begin

          str2:= copy(inputStr, 1, 2); //pi, ln
          str3:= copy(inputStr, 1, 3); //sin, cos, tan, log, l10
          str4:= copy(inputStr, 1, 4); // sqrt
          str5:= copy(inputStr, 1, 5); // sqrtn log10
          str6:= copy(inputStr, 1, 6); // arctan arcsin arccos

          if (str2='pi') or (str2='ln') then
          begin
            if str2='pi' then
              begin
                atoms[i]:='p';
              end
              else atoms[i]:='n';
              Inc(i);
            delete(inputStr, 1, 2);
          end
          else
          begin
            case str3 of
              'sin':
              begin
                atoms[i]:='s'; Inc(i);
                delete(inputStr, 1, 3);
              end;
              'cos':
                begin
                atoms[i]:='c'; Inc(i);
                delete(inputStr, 1, 3);
                end;

              'tan':
                begin
                 atoms[i]:='t'; Inc(i);
                 delete(inputStr, 1, 3);
                end;
              'log':
                begin
                atoms[i]:='l'; Inc(i);
                delete(inputStr, 1, 3);
                end;
            end;

            // sqrt log10 arctan arccos arcsin sqrtn
            if str4='sqrt' then
              begin
                atoms[i]:='r'; Inc(i);
                delete(inputStr, 1, 4);
              end;

            case str5 of
              'log10':
                begin
                  atoms[i]:='g'; Inc(i);
                delete(inputStr, 1, 5);
                end;
              'sqrtn':
                begin
                  atoms[i]:='z'; Inc(i);
                delete(inputStr, 1, 5);
                end;
            end;

            case str6 of
              'arcsin':
                begin
                  atoms[i]:='w'; Inc(i);
                delete(inputStr, 1, 6);
                end;
              'arccos':
                begin
                  atoms[i]:='x'; Inc(i);
                delete(inputStr, 1, 6);
                end;
              'arctan':
                begin
                   atoms[i]:='y'; Inc(i);
                delete(inputStr, 1, 6);
                end;
            end;


          end;
        end;
      end;

    end
    else // If it is a number
    begin

        // Get the number and its length
        number:=getNumber(inputStr);
        len:=Length(number);

      // Remove it from the original string
         Delete(inputStr, 1, len);

      // Add the number to the array of strings

      if neg=True then
      begin
        neg:=False;
        number:=negStr+number;
      end;

      atoms[i]:= number;
      Inc(i);
    end;
  end;

  len := i; // the amount of atoms stored
  setLength(atoms, len);
  getAtoms:=atoms;
end;

// Defining the left associativity of operators
function ILA(op:char):integer;
begin

  case op of
  '~':ILA:=0;
  '+':ILA:=1;
  '-':ILA:=0;
  '*':ILA:=1;
  '/':ILA:=0;
  '^':ILA:=0;
  end;


end;

// Defining the precedence of operators
function Precedence(op:char):integer;
begin

  case op of
    '~':Precedence:=1;
    '+':Precedence:=2;
    '-':Precedence:=2;
    '*':Precedence:=3;
    '/':Precedence:=3;
    '^':Precedence:=4;
    '!':Precedence:=5;
    '#':Precedence:=-1;
  end;



end;

// Getting the prefix notation
function getPrefix(atoms:stringArray):queue;

var
  i:integer;
  op:char;
  atom:string;
  len:integer;
  top:PCharNode;
  fila:queue;

begin
   InitializeQueue(fila);  // Inicializando fila

   top := new(PCharNode); // Inicializando pilha
   top^.next := nil;
   top^.value := '#';

   len:=Length(atoms);

   for i:=1 to len-1 do
   begin


     atom := atoms[i];
     if Length(atom) = 1 then op:=atom[1];


     if (isNumber(atom)) or (atom='p') or (op = 'e') then Enqueue(fila, atom); // If it is a number, put it in the output queue

     if isFunction(atom) then
       begin
         push(top, op); // If it is a function, put it in the operator stack
       end;

     if isOperator(atom) then  // If it is an operator
     begin      // While the stack top doesn't have a left parenthesis and the precedence of the stack top operator is greater than the current operator or...
       while (top<>nil) and (top^.value <> '(') and ((Precedence(top^.value) > Precedence(op)) or ((Precedence(top^.value) = Precedence(op)) and (ILA(op) = 1))) do Enqueue(fila, ''+pop(top)); // Pop the operator from the operator stack into the output queue
       push(top, op); // And then add the current operator to the stack
     end;

     if op='(' then
       begin
         push(top,op);
       end;
     if atom=')' then
     begin
       while top^.value<>'(' do Enqueue(fila, pop(top));
       pop(top);

       if isFunction(top^.value) then Enqueue(fila, pop(top));

     end;

   end;
   while(top<>nil) and (top^.value<>'#') do Enqueue(fila, ''+pop(top));
   getPrefix:=fila;

end;
 // ============================================================================




 // EXPRESSION EVALUATION =======================================================
// Custom float-string conversion functions
function getFloat(s:string):real;
var
  neg:boolean;
  x:real;
begin
  DecimalSeparator:='.';
    neg:=False;

  if s[1]='~' then
  begin
    Delete(s,1,1);
    neg:=True;
  end;
  x:=StrToFloat(s);

  if neg=True then x:=-1*x;
  getFloat:=x;
end;
function floattostring(x:real):string;
var
  s:string;
begin
  DecimalSeparator:='.';
  s:=floattostr(x);
  if s[1]='-' then
  begin
    Delete(s,1,1);
    s:='~' + s
  end;
  floattostring:=s;
end;


// Funções básicas
 function fadd(s1:string; s2:string):string;
 var
   x:real;
   y:real;
   res:string;

 begin
    x:=getFloat(s1);
    y:=getFloat(s2);


   {$ASMMODE intel}
   asm
    finit
    fld x
    fld y
    fadd
    fstp x
   end;

   fadd:=floattoString(x);


 end;

function fsub(s1:string; s2:string):string;
var
  x:real;
  y:real;
  res:string;

begin


  x:=getFloat(s1);
  y:=getFloat(s2);



  {$ASMMODE intel}
  asm
   finit
   fld x
   fld y
   fsub
   fstp x
  end;

  fsub:=floattostring(x);


end;

function fdiv(s1:string; s2:string):string;
var
  x:real;
  y:real;
  res:string;

begin

   x:=getFloat(s1);
    y:=getFloat(s2);



  {$ASMMODE intel}
  asm
   finit
   fld x
   fld y
   fdiv
   fstp x
  end;

  fdiv:=floattostring(x);


end;

function fmul(s1:string; s2:string):string;
var
  x:real;
  y:real;
  res:string;


begin

    x:=getFloat(s1);
    y:=getFloat(s2);

  {$ASMMODE intel}
  asm
   finit
   fld x
   fld y
   fmul
   fstp x
  end;

  fmul:=floattostring(x);


end;

function fpow(s1:string; s2:string):string;
var
  x:real;
  y:real;

  res:string;

begin
    x:=getFloat(s1);
    y:=getFloat(s2);

  {$ASMMODE intel}
  asm
   finit
   fld y
   fld1
   fld x
   fyl2x
   fmul
   fld st  // não permitiu fld apenas para duplicar o topo, então fld st deve funcionar para isso
   frndint
   fsub st(1),st
   fxch
   f2xm1
   fld1
   fadd
   fscale
   fstp x  // no exemplo ele volta para uma variavel r, com fstp r, caso o resultado dessa função saia errado, pode ser esse o problema
  end;

  fpow:=floattostring(x);


end;



// trigonometricas em graus
function fgcos(s1:string):string;
var
  x:real;
  res:string;
  y:real;

begin
  x:=getFloat(s1);
  y:=180;
  while x>360 do x:=x-360;
  {$ASMMODE intel}
  asm
   finit
   fld x
   fld y
   fdiv
   fldpi
   fmul
   fcos
   fstp x
  end;

  fgcos:=floattostring(x);


end;
                                                                                                                    //n! for n in [0,1] = e^(-(x^(1/n)))
function fgsin(s1:string):string;
var
  x:real;
  res:string;
  y:real;

begin
    x:=getFloat(s1);
    y:=180;
    while x>360 do x:=x-360;
  {$ASMMODE intel}
  asm
   finit
   fld x
   fld y
   fdiv
   fldpi
   fmul
   fsin
   fstp x
  end;

  fgsin:=floattostring(x);


end;

function fgtan(s1:string):string;
var
  x:real;
  y:real;
  res:string;

begin
  x:=getFloat(s1);y:=180;
  while x>360 do x:=x-360;
  {$ASMMODE intel}
  asm
   finit
   fld x
   fld y
   fdiv
   fldpi
   fmul
   fsincos
   fdivr
   fstp x
  end;

  fgtan:=floattostring(x);


end;

// trigonometricas em radianos
function frcos(s1:string):string;
var
  x:real;
  res:string;
  y:real;

begin
  x:=getFloat(s1);
  y:=180;
  while x>2*getFloat(replaceConstant('p')) do x:=x-2*getFloat(replaceConstant('p'));
  {$ASMMODE intel}
  asm
   finit
   fld x
   fcos
   fstp x
  end;

  frcos:=floattostring(x);


end;
                                                                                                                    //n! for n in [0,1] = e^(-(x^(1/n)))
function frsin(s1:string):string;
var
  x:real;
  res:string;
  y:real;

begin
    x:=getFloat(s1);
    y:=180;
    while x>2*getFloat(replaceConstant('p')) do x:=x-2*getFloat(replaceConstant('p'));
  {$ASMMODE intel}
  asm
   finit
   fld x
   fsin
   fstp x
  end;

  frsin:=floattostring(x);


end;

function frtan(s1:string):string;
var
  x:real;
  y:real;
  res:string;

begin
  x:=getFloat(s1);y:=180;
  while x>2*getFloat(replaceConstant('p')) do x:=x-2*getFloat(replaceConstant('p'));
  {$ASMMODE intel}
  asm
   finit
   fld x
   fsincos
   fdiv
   fstp x
  end;

  frtan:=floattostring(x);


end;

function fgarctan(s1:string):string;
var
  x:real;
  y:real;
  res:string;

begin
  x:=getFloat(s1);y:=180;
  //while x>2*getFloat(replaceConstant('p')) do x:=x-2*getFloat(replaceConstant('p'));
  {$ASMMODE intel}
  asm
   finit
   fld x
   fld1
   fpatan
   //fstp x
   fldpi
   fdiv
   fld y
   fmul
   fstp x
  end;

  fgarctan:=floattostring(x);


end;

function frarctan(s1:string):string;
var
  x:real;
  y:real;
  res:string;

begin
  x:=getFloat(s1);y:=180;
  //while x>2*getFloat(replaceConstant('p')) do x:=x-2*getFloat(replaceConstant('p'));
  {$ASMMODE intel}
  asm
   finit
   fld x
   fld1
   fpatan
   fstp x
  end;

  frarctan:=floattostring(x);


end;

// Fatorial
function fact(s1:string):string;
var
  x:real;
  y:real;
  e:real;
begin
   x:=getFloat(s1);
  y:=1;
  {$ASMMODE intel}
  asm

  fld x
  fld st
  fld1
  fsub

  @loop:
  fxch
  fld st(1)
  fmul

  fxch

  fld1
  fsub

  ftst
  fstsw ax
  sahf
  ja @loop


  fstp x
  fstp x
  end;


  fact:=floattostring(x);

end;

// Logaritmicas
function log(base:string;num:string):string;
var
  x:real;
  n:real;

begin
  n:=getFloat(base);
  x:=getFloat(num);

  {$ASMMODE intel}
  asm
    finit
    fld1
    fld n
    fyl2x
    fld1
    fdiv st, st(1)
    fld x
    fyl2x
    fstp x
  end;

   log:=floattostring(x);


end;

function faux(s1:string):string;
var
  x:real;
begin
   x:=getFloat(s1);
  {$ASMMODE intel}
  asm
    fld x
    fld st
    fmul
    fld1
    fsubr
    fsqrt
    fld x
    fdivr
    fstp x
  end;

  faux:=floattostring(x);

end;

function fauxr(s1:string):string;
var
  x:real;
begin
   x:=getFloat(s1);
  {$ASMMODE intel}
  asm
    fld x
    fld st
    fmul
    fld1
    fsubr
    fsqrt
    fld x
    fdiv
    fstp x
  end;

  fauxr:=floattostring(x);

end;




function evaluate(fila:queue):string;
var
  aux:PNode;
  top:PNode;
  e:string;
  temp:string;

begin
  e:=replaceConstant('e');

  aux:=fila.front;
  new(top);

  while (aux<>nil) do   // Going through the whole list of strings
  begin
    // If it is a number, push it to the stack
    if isNumber(aux^.data) or isConstant(aux^.data) then
      begin

        if isConstant(aux^.data) then begin pushS(top, replaceConstant(aux^.data)); end
        else pushS(top, aux^.data);
      end
    else // If it is not a number

      case aux^.data of
        '+':pushS(top, fadd(popS(top),popS(top)));
        '-':pushS(top, fsub(popS(top),popS(top)));
        '*':pushS(top, fmul(popS(top),popS(top)));   // BASICAS
        '/':pushS(top, fdiv(popS(top),popS(top)));
        '^':pushS(top, fpow(popS(top),popS(top)));

        't':
          begin
            if Radianos=True then pushS(top, frtan(popS(top)));
            if Radianos=False then pushS(top, fgtan(popS(top)));
          end;
        'c':
          begin
            if Radianos=True then pushS(top, frcos(popS(top)));
            if Radianos=False then pushS(top, fgcos(popS(top)));
          end;
        's':
          begin
            if Radianos=True then pushS(top, frsin(popS(top)));
            if Radianos=False then pushS(top, fgsin(popS(top)));
          end;
        // TRIGONOMETRICAS INVERSAS


        'x':
          begin    // arccos
            if Radianos=True then pushS(top, frarctan(fauxr(popS(top))));
            if Radianos=False then pushS(top, fgarctan(fauxr(popS(top))));
          end;
        'w':
          begin    //arcsin
            if Radianos=True then pushS(top, frarctan(faux(popS(top))));
            if Radianos=False then pushS(top, fgarctan(faux(popS(top))));
          end;
        'y':
          begin    //arctan
            if Radianos=True then pushS(top, frarctan(popS(top)));
            if Radianos=False then pushS(top, fgarctan(popS(top)));
          end;



        '!':pushS(top, fact(popS(top)));            // FATORIAL

        'l':pushS(top, log(popS(top), popS(top)));
        'n':pushS(top, log(e, popS(top)));          // LOGARITMICAS
        'g':pushS(top, log('10', popS(top)));

        'r':pushS(top, fpow(popS(top), '0.5'));     // Raiz quadrada
        'z':pushS(top, fpow(popS(top), fdiv('1', popS(top))));  // enésima raiz                     //b^1/rp
      end;

    aux:=aux^.next;
  end;
    evaluate:=popS(top);
end;


// MAIN




procedure TForm1.ButtonEqualClick(Sender: TObject);
var
  atoms:stringArray;
  fila:queue;
  result:string;

  aux:PNode;
begin
  expression := Edit1.Text;

  atoms:=getAtoms(expression);

  fila:=getPrefix(atoms);
  //new(aux);
  //result:='';
  //aux:=fila.front;
  //
  //while aux<>nil do              // uSAD
  //begin
  //  result:=result+aux^.data;
  //  aux:=aux^.next;
  //end;


  result:=evaluate(fila);




  Edit2.Text := result;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

procedure TForm1.Edit3Change(Sender: TObject);
begin

end;

procedure TForm1.ButtonClick(Sender: TObject);
begin
  // Append the button's caption to the Edit1 text
  Edit1.Text := Edit1.Text + (Sender as TButton).Caption;
end;

procedure TForm1.ButtonBackspaceClick(Sender: TObject);
begin
  // Remove the last character from the Edit1 text
  if Length(Edit1.Text) > 0 then
    Edit1.Text := Copy(Edit1.Text, 1, Length(Edit1.Text) - 1);
end;

procedure TForm1.ButtonCEClick(Sender: TObject);
begin
  // Clear the Edit1 text
  Edit1.Clear;
end;

procedure TForm1.ButtonCClick(Sender: TObject);
begin
  // Clear the Edit1 text
  Edit1.Clear;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
    Radianos := True;
end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  Radianos := False;
end;

end.
