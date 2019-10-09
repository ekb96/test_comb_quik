--скрипт для выгрузки лога из графика QUIK

myPrice	=	"Price_1min"																--идентификатор цены
myEMA	=	"Ema_1min"																	--идентификатор скользящей
symbol	=	5																			--кол-во символов для обрезки

is_run = true
function main()
	-------------------------------------------------------------
	Adress_File = "C:\\Users\\AR\\Desktop\\Python\\Combination\\log_new.txt"				--файл дла чтения/записи лога
	-------------------------------------------------------------
	FileRead = io.open(Adress_File, "r")												--открыть файл в режиме чтени€
		while (No ~= 0) do                                                             	--выполнить пока справедливо условие
			No,Date,Time,Price,PriceT = FileRead:read("*n","*n","*n","*n","*n")			--получить данные
			if No == nil then break end													--если последняя строка пустая - стоп цикл
			No1 = No
			Date1 = Date																--последняя дата в логе
			Time1 = Time																--последнее врем€ в логе
			sleep(0.1)																	--пауза
		end
		--message(tostring(Date1).."	"..tostring(Time1))								--сообщение с последними датой и временем
		if Date1 == nil then															--если файл изначально пуст - бит = 1
			bits = 1
			No1 = 0
		end
	FileRead:close()																	--закрыть файл лога
	-------------------------------------------------------------
	FileWrite = io.open(Adress_File, "a")												--открыть файл для записи лога
	sv = 1																				--номер начальной свечи
	N=getNumCandles(myPrice)															--график цены (число свечей)
	N1=getNumCandles(myEMA)																--график скользящей (число свечей)
	-------------------------------------------------------------
	while is_run do																		--основной цикл записи в лог
		---------------------------------------------------------
		t,n,i=getCandlesByIndex(myPrice, 0, 1+sv, 1)									--получить данные свечи цены
		t1,n1,i1=getCandlesByIndex(myEMA, 0, 1+sv, 1)									--получить данные скользящей
		---------------------------------------------------------
		if t[0] == nil then break end													--если последней свечи нет -стоп цикл
		---------------------------------------------------------
		hour_s  = tonumber(t[0].datetime.hour)											--часы
		min_s   = tonumber(t[0].datetime.min)											--минуты
		year_s  = tonumber(t[0].datetime.year)											--год
		month_s = tonumber(t[0].datetime.month)											--месяц
		day_s   = tonumber(t[0].datetime.day)											--день
		dats    = tostring(day_s.."."..month_s.."."..year_s)							--дата
		if hour_s  < 10 then hour_s  = "0"..hour_s  end									--добавить "0" перед цифрой
		if min_s   < 10 then min_s   = "0"..min_s   end									--добавить "0" перед цифрой
		if month_s < 10 then month_s = "0"..month_s end									--добавить "0" перед цифрой
		if day_s   < 10 then day_s   = "0"..day_s   end									--добавить "0" перед цифрой
		---------------------------------------------------------
		Time_Date = hour_s..min_s.."00"													--время
		Date_Time = year_s..month_s..day_s												--дата
		---------------------------------------------------------
		if bits == 1 then																--если бит = 1, записать данные
			t_price  = string.sub(t[0].close,1,symbol)									--обрезать цену
			t_ema	 = string.sub(t1[0].close,1,symbol)									--обрезать скользящю
			No1 = No1 + 1
			-----------------------------------------------------						--записать данные
			FileWrite:write(No1.."	"..Date_Time.."	"..Time_Date.."	"..t_ema.."	"..t_price.."\n")
			-----------------------------------------------------
		end
		---------------------------------------------------------						--продолжить лог с прошой даты/времени
		if tostring(Date_Time) == tostring(Date1) and tostring(Time_Date) == tostring(Time1) then
			bits = 1																	--разрешающий бит
		end
		---------------------------------------------------------
		sv = sv+1																		--номер следующей свечи
		sleep(0.1)																		--пауза
	end
	-------------------------------------------------------------
	FileWrite:close()																	--закрыть файл лога
	-------------------------------------------------------------
	message("stop log",3)													--соообщение окончания скрипта
	-------------------------------------------------------------
end

function OnStop(stop_flag)
	is_run = false
end