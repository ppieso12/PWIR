with ada.text_io; use ada.text_io;
with ada.Exceptions; use ada.Exceptions;
with Ada.Calendar;
use Ada.Calendar;

procedure normalizacja is

  type Sample is new Float range 0.0..1.0;

  type SND is array (Positive range <>) of Sample;

  task watek is
    entry Start(dzwiek: in out SND; startt: Integer; dlugosc_obliczen: Integer;max: Sample);
    entry Pobierz(dzwiek: in out SND; startt: out Integer);
  end watek;

  task body watek is

    watek_dzwiek:SND;
    watek_start: Integer;
    watek_dl_ob: Integer;
    watek_max: Sample;

  begin
    accept Start(dzwiek : in out SND; startt : in Integer; dlugosc_obliczen : in Integer; max : in Sample) do
      watek_max := max;
      watek_dl_ob := dlugosc_obliczen;
      watek_start:= startt;
      watek_dzwiek := dzwiek;
    end Start;
    for I in watek_start..(watek_start+watek_dl_ob) loop
      watek_dzwiek(I) := watek_dzwiek(I) / watek_max;
    end loop;

    accept Pobierz (dzwiek : in out SND; startt: out Integer) do
      dzwiek:= watek_dzwiek;
      startt:= watek_start;
    end Pobierz;


  end watek;



  procedure norm(Sound: in out SND; liczba_p : Integer) is

    max_elem : Sample := 0.94;
    zakres: Integer := Sound'Range;
    ilosc_na_jeden_watek : Integer := zakres / liczba_p;
    tablica_watkow: array(1..liczba_p) of watek;
    nowa: SND;
    startZwatku: Integer;
    iter: Integer;

    begin
      for I in 1..liczba_p loop
	tablica_watkow(I).Start(Sound,(I-1)*ilosc_na_jeden_watek,ilosc_na_jeden_watek,max_elem);
      end loop;

      for I in 1..liczba_p loop
	tablica_watkow(I).Pobierz(nowa,startZwatku);
	iter:= 1;

	for J in startZwatku..(startZwatku+ilosc_na_jeden_watek) loop
	  Sound(J) := nowa(iter);
	  iter:=iter+1;
	end loop;

      end loop;
    end norm;

    tablica:SND:=(0.20,0.11,0.45,0.99,0.75,0.31,0.72,0.81,0.91,0.10);
  begin

    Put_Line("przed: " & tablica'Img);
    norm(tablica,10);
    Put_Line("po: " & tablica'Img);



end normalizacja;
