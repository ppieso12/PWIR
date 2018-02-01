with ada.text_io; use ada.text_io;
with ada.Exceptions; use ada.Exceptions;
   with Ada.Calendar;
  use Ada.Calendar;


procedure test is

  function dziel(liczba, dzielnik: Float) return Float is
    Wynik: Float;
    Zero: exception;
  Begin
    if dzielnik = 0.0 then
      raise Zero with "Nie dziel przez zero";
    else
      Wynik := liczba/dzielnik;
    end if;

     return Wynik;
  end dziel;



  task rozpocznij is
    entry start;
    entry odbierz_wyniki;
  end rozpocznij;

  task body rozpocznij is
    procedure fix is
    begin
       delay 0.5;
    end fix;

  begin

    accept start do
      put_line("Rozpoczecie ratowania swiata");
    end start;
    fix;

    accept odbierz_wyniki do
      put_line("przekazywanie wynikow");
    end odbierz_wyniki;


  end rozpocznij;


  procedure fixworld is
    procedure xx is
    begin
      delay 0.9;
      put_line("xx");
    end xx;

  begin
    select
      delay 1.0;
      put_line("nie wykonano xx");
    then abort
      xx;
    end select;
  end fixworld;


  procedure blabla is
  begin
    delay 0.4;
    put_line("blalba\n");
  end blabla;

  procedure jaaaa is
  begin
    delay 2.5;
    put_line("naprawiono");
  end jaaaa;



  W: Float;
  Nastepny     : Ada.Calendar.Time := Clock;
  Okres        : constant Duration := 0.5; -- ");sekundy
begin
  rozpocznij.start;

  select

    delay 1.0;
    put_line("Za dlugie oczekiwanie");
  then abort
    rozpocznij.odbierz_wyniki;


  end select;


  select

    rozpocznij.odbierz_wyniki;

  or
    delay 1.0;
      put_line("Za dlugie oczekiwanie");





  end select;





  W:= dziel(2.0,0.0);
  Put_Line(W'Img);

exception
  when E: others => Put_Line(Exception_Name(E) & "  "& Exception_Message(E));




  loop
    fixworld;
  end loop;




  loop


    Nastepny:= Nastepny + Okres;
    blabla;
    delay until Nastepny;

  end loop;






end test;



