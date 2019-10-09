--������ ��� �������� ���� �� ������� QUIK

myPrice	=	"Price_1min"																--������������� ����
myEMA	=	"Ema_1min"																	--������������� ����������
symbol	=	5																			--���-�� �������� ��� �������

is_run = true
function main()
	-------------------------------------------------------------
	Adress_File = "C:\\Users\\AR\\Desktop\\Python\\Combination\\log_new.txt"				--���� ��� ������/������ ����
	-------------------------------------------------------------
	FileRead = io.open(Adress_File, "r")												--������� ���� � ������ ������
		while (No ~= 0) do                                                             	--��������� ���� ����������� �������
			No,Date,Time,Price,PriceT = FileRead:read("*n","*n","*n","*n","*n")			--�������� ������
			if No == nil then break end													--���� ��������� ������ ������ - ���� ����
			No1 = No
			Date1 = Date																--��������� ���� � ����
			Time1 = Time																--��������� ����� � ����
			sleep(0.1)																	--�����
		end
		--message(tostring(Date1).."	"..tostring(Time1))								--��������� � ���������� ����� � ��������
		if Date1 == nil then															--���� ���� ���������� ���� - ��� = 1
			bits = 1
			No1 = 0
		end
	FileRead:close()																	--������� ���� ����
	-------------------------------------------------------------
	FileWrite = io.open(Adress_File, "a")												--������� ���� ��� ������ ����
	sv = 1																				--����� ��������� �����
	N=getNumCandles(myPrice)															--������ ���� (����� ������)
	N1=getNumCandles(myEMA)																--������ ���������� (����� ������)
	-------------------------------------------------------------
	while is_run do																		--�������� ���� ������ � ���
		---------------------------------------------------------
		t,n,i=getCandlesByIndex(myPrice, 0, 1+sv, 1)									--�������� ������ ����� ����
		t1,n1,i1=getCandlesByIndex(myEMA, 0, 1+sv, 1)									--�������� ������ ����������
		---------------------------------------------------------
		if t[0] == nil then break end													--���� ��������� ����� ��� -���� ����
		---------------------------------------------------------
		hour_s  = tonumber(t[0].datetime.hour)											--����
		min_s   = tonumber(t[0].datetime.min)											--������
		year_s  = tonumber(t[0].datetime.year)											--���
		month_s = tonumber(t[0].datetime.month)											--�����
		day_s   = tonumber(t[0].datetime.day)											--����
		dats    = tostring(day_s.."."..month_s.."."..year_s)							--����
		if hour_s  < 10 then hour_s  = "0"..hour_s  end									--�������� "0" ����� ������
		if min_s   < 10 then min_s   = "0"..min_s   end									--�������� "0" ����� ������
		if month_s < 10 then month_s = "0"..month_s end									--�������� "0" ����� ������
		if day_s   < 10 then day_s   = "0"..day_s   end									--�������� "0" ����� ������
		---------------------------------------------------------
		Time_Date = hour_s..min_s.."00"													--�����
		Date_Time = year_s..month_s..day_s												--����
		---------------------------------------------------------
		if bits == 1 then																--���� ��� = 1, �������� ������
			t_price  = string.sub(t[0].close,1,symbol)									--�������� ����
			t_ema	 = string.sub(t1[0].close,1,symbol)									--�������� ���������
			No1 = No1 + 1
			-----------------------------------------------------						--�������� ������
			FileWrite:write(No1.."	"..Date_Time.."	"..Time_Date.."	"..t_ema.."	"..t_price.."\n")
			-----------------------------------------------------
		end
		---------------------------------------------------------						--���������� ��� � ������ ����/�������
		if tostring(Date_Time) == tostring(Date1) and tostring(Time_Date) == tostring(Time1) then
			bits = 1																	--����������� ���
		end
		---------------------------------------------------------
		sv = sv+1																		--����� ��������� �����
		sleep(0.1)																		--�����
	end
	-------------------------------------------------------------
	FileWrite:close()																	--������� ���� ����
	-------------------------------------------------------------
	message("stop log",3)													--���������� ��������� �������
	-------------------------------------------------------------
end

function OnStop(stop_flag)
	is_run = false
end