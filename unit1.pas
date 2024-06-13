unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Interfaces;

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
    Edit1: TEdit;
    ButtonAdd: TButton;
    ButtonEqual: TButton;
    Button0: TButton;
    Button1: TButton;
    Button2: TButton;
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
    procedure ButtonEqualClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure ButtonBackspaceClick(Sender: TObject);
    procedure ButtonCEClick(Sender: TObject);
    procedure ButtonCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Expression: string; // Declare the variable to store the expression

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
        writeln('Stack is empty');
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
        writeln('Stack is empty');
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
        writeln('Queue is empty!');
        Dequeue:='empty_queue';
    end
    else
    begin
      tempNode := fila.front;    // Temporary node is the firs node of the queue
      data := tempNode^.data; // Value is the data held by that node
      fila.front := fila.front^.next; // The front of the queue is iterated

      if fila.front = nil then // If the queue had only one element left, set both its start and its end to nil
         writeln('queue is empty');
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
  out:string;
  i:Integer;
  len:Integer;
  pointFound:Integer;

begin
  out:=''; pointFound:=0;
  len := Length(str);
  for i := 1 to len do
  begin



    if (str[i]<>'0') and (str[i]<>'1') and (str[i]<>'2') and (str[i]<>'3') and (str[i]<>'4') and (str[i]<>'5') and (str[i]<>'6') and (str[i]<>'7') and (str[i]<>'8') and (str[i]<>'9') then
    begin

      // If the current char is not a number, check whether it is a point
      if(str[i]='.') then   // If it is a point
      begin
        if pointFound=1 then break             // And has already been found, break.
        else
            begin
              out:=out+str[i]; // If it hasn't already been found, accept it and pointFound=1
              pointFound:=1;
            end;
        // If it is a point, set pointFound to true and append the point to the out string

      end
      else  // If is neither a point nor a number, break out of the loop
        begin

             break;
        end;
    end
    else
        begin
        // If it is a number, append it

        out:=out+str[i];
        end;
  end;
  getNumber:=out;
end;

function isNumber(str:string):Boolean;
begin
  if(getNumber(str)=str)then begin isNumber:=True;end
  else isNumber:=False;
end;
function isOperator(str:string):Boolean;
begin
  if (str = '+') or (str = '-') or (str = '/') or (str = '*') or (str = '^') or (str = '~') then begin isOperator:=True;end
  else isOperator:=False;
end;
function isFunction(str:string):Boolean;
begin
  if (str='s') or (str='c') or (str='t') or (str='l') or (str='n') then begin isFunction:=True; end
  else isFunction:=False;
end;

function isConstant():integer;
begin
end;

// Getting the tokens out of an expression
function getAtoms(inputStr:string):stringArray;
var
  len:integer;
  i:integer;
  atoms:stringArray;
  number:string;
  op: char;

  str2:string;
  str3:string;
begin

  SetLength(atoms, 100000);

  // Create an array of strings, where the strings are either numbers or operators
  i:=1;
  while length(inputStr) > 0 do // While we haven't reached the end of the string
  begin

    while(inputStr[1]=' ') do Delete(inputStr, 1,1);

    if (inputStr[1]<>'0') and (inputStr[1]<>'1') and (inputStr[1]<>'2') and (inputStr[1]<>'3') and (inputStr[1]<>'4') and (inputStr[1]<>'5') and (inputStr[1]<>'6') and (inputStr[1]<>'7') and (inputStr[1]<>'8') and (inputStr[1]<>'9') then
    begin // If it is not a number

      // If it is an operator
      if (inputStr[1] = '+') or (inputStr[1] = '-') or (inputStr[1] = '*') or (inputStr[1] = '/') or (inputStr[1] = '^') or (inputStr[1] = '(') or (inputStr[1] = ')') then
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
          str3:= copy(inputStr, 1, 3); //sin, cos, tan, log,

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
              end;
              'cos':
                begin
                atoms[i]:='c'; Inc(i);
                end;

              'tan':
                begin
                 atoms[i]:='t'; Inc(i);
                end;
              'log':
                begin
                atoms[i]:='l'; Inc(i);
                end;
            end;
            delete(inputStr, 1, 3);
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
      atoms[i]:= number;
      Inc(i);
    end;
  end;

  len := i; // the amount of atoms stored
  setLength(atoms, len);
  writeln('TOKENS: ');for i:=1 to len-1 do write(atoms[i],'  ');
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
    '!':Precedence:=-1;
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
   top^.value := '!';

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
   while(top<>nil) do Enqueue(fila, ''+pop(top));
   getPrefix:=fila;

end;
 // ============================================================================




 // EXPRESSION EVALUATION =======================================================

 function fadd(s1:string; s2:string):string;
 var
   x:real;
   y:real;
   res:string;

 begin
    DecimalSeparator := '.';
    x:=StrToFloat(s1);
    y:=StrToFloat(s2);

   {$ASMMODE intel}
   asm
    finit
    fld x
    fld y
    fadd
    fstp x
   end;

   fadd:=FloatToStr(x);


 end;



procedure evaluate(fila:queue); // Expressão -> Tokens -> Polonesa (Pilha, fila) -> Varredura única (chamadas a funções da FPU)
var
  aux:PNode;
  top:PNode;
  data:string;

begin
  aux:=fila.front;
  new(top);

  while (aux^.next<>nil) do   // Going through the whole list of strings
  begin
    // If it is a number, push it to the stack
    if (aux^.data = getNumber(aux^.data)) then
      begin
         pushS(top, aux^.data);
      end
    else // If it is not a number

      case aux^.data of
        '+':
        begin
          data := fadd(popS(top),popS(top));
          pushS(top, data);
        end;
        '-':continue;
        '*':continue;
        '/':continue;
        '^':continue;
      end;

    aux:=aux^.next;
  end;
    writeln('result: ', top^.data);
end;


// MAIN



procedure TForm1.ButtonEqualClick(Sender: TObject);
begin
  Expression := Edit1.Text;
  Edit2.Text := Expression;
end;

procedure TForm1.Edit2Change(Sender: TObject);
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

end.

