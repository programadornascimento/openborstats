unit Unt_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.GIFImg;

type
  TForm1 = class(TForm)

  Image1: TImage;
    Lb_Start_x: TLabel;
    Lb_Start_y: TLabel;
    Lb_Old_End_X: TLabel;
    Lb_Old_End_Y: TLabel;
    Lb_Start_x_conteudo: TLabel;
    Lb_Start_y_conteudo: TLabel;
    Lb_End_X_conteudo: TLabel;
    Lb_End_Y_conteudo: TLabel;
    Lb_Ori: TLabel;
    Image2: TImage;
    Lb_dobro: TLabel;

  procedure atualiza;
  procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
  procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
  procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);

 procedure PegaArquivo;
    procedure FormCreate(Sender: TObject);

  private
  { Private declarations }
  public
  { Public declarations }
  end;


  var
  Form1 : TForm1;
  StartX : Integer;
  StartY : Integer;
  OldStartX : Integer;
  OldStartY : Integer;
  OldEndX : Integer;
  OldEndY : Integer;
  IsDown : Boolean;

  altura_ori, largura_ori : integer;
  nome_do_arquivo: string;

  implementation

  {$R *.DFM}


procedure TForm1.FormCreate(Sender: TObject);
begin
  nome_do_arquivo:='F:\_JOGOS\OPENBOR\Marvel Infinit War-v2.11\MIW_v2\Data\chars\punisher\b3.gif';
  PegaArquivo;
  image1.Picture.LoadFromFile(nome_do_arquivo);


    Image2.Picture.Bitmap.Height := altura_ori*2;
    Image2.Picture.Bitmap.Width  := largura_ori*2;
    Image2.Height := altura_ori*2;
    Image2.Width  := largura_ori*2;
    image2.Picture.LoadFromFile(nome_do_arquivo);
    Application.ProcessMessages;

end;





procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
    IsDown := True;

    StartX := X;
    StartY := Y;
    OldStartX := X;
    OldStartY := Y;
    OldEndX := X;
    OldEndY := Y;
  end;

  procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  begin
    if IsDown then
    begin
      atualiza;
      Canvas.Pen.Style := psDot;
      Canvas.Pen.Mode  := pmNotXor;
      Canvas.Rectangle(OldStartX, OldStartY, OldEndX, OldEndY);
      OldEndX := X;
      OldEndY := Y;
      Canvas.Rectangle(StartX, StartY, X, Y);
    end;
  end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    IsDown := False;
    Canvas.Pen.Style := psDot;
    Canvas.Pen.Mode  := pmNotXor;
    Canvas.Rectangle(OldStartX, OldStartY, OldEndX, OldEndY);

end;


procedure TForm1.atualiza;
  begin
    Lb_Start_x_conteudo.Caption    := intToStr(StartX);
    Lb_Start_y_conteudo.Caption    := intToStr(StartY);
    Lb_End_X_conteudo.Caption      := intToStr(OldEndX);
    Lb_End_Y_conteudo.Caption      := intToStr(OldEndY);


    Lb_Ori.Caption := intToStr(altura_ori) +' x '+ intToStr(largura_ori);
    Lb_dobro.Caption := intToStr(altura_ori*2) +' x '+ intToStr(largura_ori*2);

    Application.ProcessMessages;
  end;

  procedure TForm1.PegaArquivo;
  begin
    with TGifImage.Create do
    begin
      //LoadFromFile('K:\Mulheres\Ellen Rocche01.jpg');
      LoadFromFile(nome_do_arquivo);
      altura_ori:=height;
      largura_ori:=width;
      free;
    end;
  end;

  end.
