# Скрипт проверки лучших комбинаций.
# Вставка лучших комбинаций осуществляется вручную.
# Выбор файла лога с реальными данными осуществляется вручную.
# В результате формируются два файла с результатами в разной форме.

import time																# импорт модуля времени

log = "log_1 min_05.19.txt"												# файл лога с реальными данными
#log = "log_1 min_06.19.txt"
#log = "log_1 min_07.19.txt"
#log = "log_1 min_08.19.txt"

cycle	= 0																# начальный цикл
profit	= 0.3															# уровень профита
stop	= 0.3															# уровень стопа

while cycle != 3:														# цикл обхода всех комбинаций
	files1 = open("5.result_one.txt", "a")									# открыть файл result.txt
	files3 = open("6.result_two.txt", "a")									# открыть файл horisont.txt

	if cycle == 0: comb_test = "1111110000"								# одна из лучших комбинаций
	if cycle == 1: comb_test = "1000000011"
	if cycle == 2: comb_test = "1111111000"
	
																		# начальные значения переменных
	em1,em2,em3,em4,em5,em6,em7,em8,em9,em10,em11,v = 0,0,0,0,0,0,0,0,0,0,0,0
	p,sd_pol,sd_otr = 0,0,0
	
	files2 = open(log, "r")												# открыть файл лога/архива
	
	for comb in files2:													# цикл обхода файла лога/архива
		n = comb.replace('\n','')										# заменить/удалить знак переноса
		m = n.split('	')												# разделяем
			
		em1 = m[3]														# поучаем значение с индексом "3" из строки
											
		if em11 != 0:													# если "em11" не равно "0"
			if em1 > em2: L1 = "1"										# если "em1" больше "em2", то "L1" равен "1"
			else: L1 = "0"												# иначе "L1" равен "0"
			if em2 > em3: L2 = "1"
			else: L2 = "0"
			if em3 > em4: L3 = "1"
			else: L3 = "0"
			if em4 > em5: L4 = "1"
			else: L4 = "0"
			if em5 > em6: L5 = "1"
			else: L5 = "0"
			if em6 > em7: L6 = "1"
			else: L6 = "0"
			if em7 > em8: L7 = "1"
			else: L7 = "0"
			if em8 > em9: L8 = "1"
			else: L8 = "0"
			if em9 > em10: L9 = "1"
			else: L9 = "0"
			if em10 > em11: L10 = "1"
			else: L10 = "0"
			comb_real = (L1+L2+L3+L4+L5+L6+L7+L8+L9+L10)				# реальная комбинация
															
			if comb_real == comb_test and v == 0:						# если реальная совпадает с тестовой
				vhod_price = m[4]										# цена входа - цена закрытия свечи
				vhod_ema = m[3]											# цена средней
				v = 1													# текущая позиция
				#print("вход " + str(m[4]))
			if v == 1 and (float(m[3])-float(vhod_ema))>profit:
				p = p + (float(m[4])-float(vhod_price))-0.03
				v = 0
				sd_pol += 1
				#print("выход положителный")
			if v == 1 and (float(vhod_ema)-float(m[3]))>stop:
				p = p + (float(m[4])-float(vhod_price))-0.03
				v = 0
				sd_otr += 1
				#print("выход отрицательный")
												
		em11 = em10														# заполняем предыдущие значения
		em10 = em9
		em9 = em8
		em8 = em7
		em7 = em6
		em6 = em5
		em5 = em4
		em4 = em3
		em3 = em2
		em2 = em1
											
		#time.sleep(0.5)												# пауза 0.5 секунд
																		# запись результата в файл
	files1.write(str(sd_pol) + "	" + str(sd_otr) + "	" + str(comb_test) + "	" + str(p)[:5] + "\n")
	files3.write(str(p)[:5] + "	")
	
	files2.close()														# закрыть файл лога/архива
	files1.close()														# закрыть файл result.txt
	files3.close()														# закрыть файл horisont.txt
	print("конец теста " + str(cycle))									# сообщение
	cycle += 1															# увеличить
	
files1 = open("5.result_one.txt", "a")										# добавить в конец файла строку
files1.write("---------------------------------------------------" + "\n")
files1.close()

files3 = open("6.result_two.txt", "a")										# добавить в конец файла строку
files3.write("\n")
files3.close()
