unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Interfaces;

type

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
    procedure Button20Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure ButtonEqualClick(Sender: TObject);
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

procedure TForm1.Button20Click(Sender: TObject);
begin

end;

procedure TForm1.Button24Click(Sender: TObject);
begin

end;

procedure TForm1.ButtonEqualClick(Sender: TObject);
begin
  Expression := Edit1.Text;
  Edit2.Text := Expression;
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

