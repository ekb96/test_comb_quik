# Скрипт создания возможных комбинаций
# и их проверки на логе тестовых данных.
# Затем необходимо отобрать комбинации с лучшими результатами
# и прогнать их через скрипт "test"

import time

comb_long = "4.comb_long.txt"											# файл для записи результатов теста
log = "log_1 min_08.19.txt"												# файл лога с данными

print("запись комбинаций...")

a = ("1","0")															# возможные значения при переборе в цикле
b = ("1","0")
c = ("1","0")
d = ("1","0")
e = ("1","0")
f = ("1","0")
g = ("1","0")
h = ("1","0")
i = ("1","0")
j = ("1","0")
	
for aa in a:															# первое значение комбинации
	for bb in b:														# второе значение комбинации
		for cc in c:													# значение знака
			for dd in d:
				for ee in e:
					for ff in f:
						for gg in g:
							for hh in h:
								for ii in i:
									for jj in j:
										files1 = open(comb_long, "a")
										# комбинация
										comb_test = (aa + bb + cc + dd + ee + ff + gg + hh + ii + jj)
										# начальные значения переменных
										em1,em2,em3,em4,em5,em6,em7,em8,em9,em10,em11,v = 0,0,0,0,0,0,0,0,0,0,0,0
										sd_pol,sd_otr = 0,0
										# открыть файл лога/архива
										files2 = open(log, "r")
										# цикл обхода файла лога/архива
										for comb in files2:
											n = comb.replace('\n','')	# заменить/удалить знак переноса
											m = n.split('	')			# разделяем
											
											#print(m[0] + "	" + m[1] + "	" + m[2] + "	" + m[3] + "	" + m[4])
											
											em1 = m[3]
											
											if em11 != 0:
												if em1 > em2: L1 = "1"
												else: L1 = "0"
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
												comb_real = (L1+L2+L3+L4+L5+L6+L7+L8+L9+L10)
												
												if comb_real == comb_test and v == 0:
													vhod_price = m[4]
													vhod_ema = m[3]
													v = 1
													#print("вход " + str(m[4]))
												if v == 1 and (float(m[3])-float(vhod_ema))>0.3:
													v = 0
													sd_pol += 1
													#print("выход положителный")
												if v == 1 and (float(vhod_ema)-float(m[3]))>0.3:
													v = 0
													sd_otr += 1
													#print("выход отрицательный")
												
											# заполняем предыдущие значения
											em11 = em10
											em10 = em9
											em9 = em8
											em8 = em7
											em7 = em6
											em6 = em5
											em5 = em4
											em4 = em3
											em3 = em2
											em2 = em1
											
											#time.sleep(0.5)
										
										files1.write(str(sd_pol) + "	" + str(sd_otr) + "	" + str(comb_test) + "\n")
										# закрыть файл лога/архива
										files2.close()
										files1.close()

print("конец записи комбинаций")
print('\n')
