require "/home/denis/Poker/lib/Poker/version"

module Poker
	#Метод преобразует индексы карт в названия для вывода на консоль
	def preobraz (a,b)
		case a
		when 0
			mast = "H"
		when 1
			mast = "D"
		when 2
			mast = "C"
		when 3
			mast = "S"
		end
		
		case b
		when 0
			karta = "2"
		when 1
			karta = "3"
		when 2
			karta = "4"
		when 3
			karta = "5"
		when 4
			karta = "6"
		when 5
			karta = "7"
		when 6
			karta = "8"
		when 7
			karta = "9"
		when 8
			karta = "10"
		when 9
			karta = "J"
		when 10
			karta = "Q"
		when 11
			karta = "K"
		when 12
			karta = "A"
		end
		@preobraz = karta+mast
	end
	#Метод для определения выигрышной комбинации
	def kombo (koloda, kombo)
		level=0
		komboName = nil
		kombo.clear
		#Проверяем есть ли Каре
		for j in 0..12
			schet =0
			for i in 0..3
				if koloda[i][j]!=0
					schet +=1
					kombo << [i,j]
					if schet == 4
						komboName = "Каре"
					end
				end
			end
			if komboName == nil
				kombo.clear
			end
		end
		#Проверяем Роял Флеш и Стрит Флеш
		for i in 0..3
			if (koloda[i][12]!=0 and koloda[i][11]!=0 and koloda[i][10]!=0 and
				koloda[i][9]!=0 and koloda[i][8]!=0)
				komboName = "Роял Флеш"
				kombo << [i,12]
				kombo << [i,11]
				kombo << [i,10]
				kombo << [i,9]
				kombo << [i,8]
			end
			if komboName == nil
				for j in 2..9
					if (koloda[i][j-2]!=0 and koloda[i][j-1]!=0 and koloda[i][j]!=0 and
						koloda[i][j+1]!=0 and koloda[i][j+2]!=0)
						komboName = "Стрит Флеш"
						kombo << [i,j-2]
						kombo << [i,j-1]
						kombo << [i,j]
						kombo << [i,j+1]
						kombo << [i,j+2]
					end
				end
			end
		end

		#Проверяем Фул Хаус
		if komboName == nil
			k2=-1
			k3=-1
			for j in 0..12
				schet = 0
				for i in 0..3
					if koloda[i][j]!=0
						schet+=1
						kombo << [i,j]
					end
				end
				if schet >= 2
					k2 = j
				elsif schet == 3 and k3 >0
					kombo.pop
				elsif schet == 3 and k3 == -1
					k3 = j
				elsif schet == 1
					kombo.pop
				end
			end
			if k2!=k3 and k2>0 and k3 >0
				komboName = "Фул Хаус"
			end
		end
		#Проверяем Флеш
		if komboName == nil
			for i in 0..3
				schet = 0
				for j in 12.downto(0)
					if koloda[i][j]!=0
						schet +=1
						kombo << [i,j]
					end
				end
				if schet == 5
					komboName = "Флеш"
				elsif schet == 6
					komboName = "Флеш"
					kombo.pop
				elsif schet ==7
					komboName = "Флеш"
					kombo.pop
					kombo.pop
				elsif schet<5 and komboName == nil
					kombo.clear
				end
			end
		end
		#Проверяем Стрит
		if komboName ==nil
			schet=0
			index=0
			masStrit = Array.new(13) { 0 }
			for j in 0..12
				for i in 0..3
					if koloda [i][j]!=0
						masStrit[j]+=1
					end
				end
			end
			for i in 2..10
				if (masStrit[i-2]!=0 and masStrit[i-1]!=0 and masStrit[i]!=0 and
					masStrit[i+1]!=0 and masStrit[i+2]!=0)
					komboName = "Стрит"
					index = i
				end
			end
			if (komboName == nil and masStrit[12]!=0 and masStrit[0]!=0 and 
				masStrit[1]!=0 and masStrit[2]!=0 and masStrit[3]!=0)
					komboName = "Стрит"
					index = 12
			end
			if index !=0 and index !=12
				for j in (index-2)..(index+2)
					schet = 0 
					for i in 0..3
						if schet ==0 and koloda[i][j]!=0
							kombo << [i,j]
							schet+=1
						end
					end
				end
			elsif index==12
				for j in 0..3
					schet =0 
					for i in 0..3
						if schet ==0 and koloda[i][j]!=0
							kombo << [i,j]
							schet+=1
						end
					end
				end
				for i in 0..3
					schet=0
					if schet ==0 and koloda[i][12]!=0
						kombo << [i,12]
						schet+=1
					end
				end
			end
		end
		#Проверяем Сет
		if komboName == nil
			k3=-1
			for j in 12.downto(0)
				schet = 0
				for i in 0..3
					if koloda[i][j]!=0
						schet+=1
						kombo << [i,j]
					end
				end
				if schet == 2
					kombo.pop
					kombo.pop
				elsif schet == 3 and k3 >0
					kombo.pop
					kombo.pop
					kombo.pop
				elsif schet == 3 and k3 == -1
					k3 = j
				elsif schet == 1
					kombo.pop
				end
			end
			if k3 >0
				komboName = "Сет"
			end
		end
		#Проверяем пару
		if komboName == nil
			k2=-1
			for j in 12.downto(0)
				schet = 0
				for i in 0..3
					if koloda[i][j]!=0
						schet+=1
						kombo << [i,j]
					end
				end
				if schet == 2 and k2>0
					kombo.pop
					kombo.pop
				elsif schet == 2 and k2 == -1
					k2=j 
				elsif schet == 1
					kombo.pop
				end
			end
			if k2 >= 0
				komboName = "Пара"
			end
		end
		#Если других комбинаций нет - находим высшую карту
		if komboName == nil
			schet =0 
			for j in 12.downto(0)
				for i in 0..3
					if koloda[i][j]!=0 and schet ==0
						schet+=1
						kombo << [i,j]
					end
				end
			end
			komboName = "Старшая карта"
		end
		@kombo = komboName	
	end

	def razdacha (koloda, igrok, stol, poker, komanda, kombo)
			#цикл для определения розданных карт
			#h= Array.new(13) { 0 }
			#d= Array.new(13) { 0 }
			#c= Array.new(13) { 0 }
			#s= Array.new(13) { 0 }
			schet =0
			koloda.clear
			koloda[0] = Array.new(13) { 0 }
			koloda[1] = Array.new(13) { 0 }
			koloda[2] = Array.new(13) { 0 }
			koloda[3] = Array.new(13) { 0 }
		while schet != 7 do
			a=rand(4)
			b=rand(13)
			if (schet < 2 and koloda[a][b]==0)
				koloda[a][b]=1
				igrok[schet]=poker.preobraz(a,b)
				schet+=1
			elsif (schet >= 2 and koloda[a][b]==0)
				koloda[a][b]=2
				stol[schet-2]=poker.preobraz(a,b)
				schet+=1
			end
		end
		if komanda !=""
			@razdacha=poker.kombo(koloda,kombo)
		end
	end
end

class NewGame
	#подключаем модуль Poker
	include Poker
	poker = NewGame.new
	flag = true
	schet=0
	koloda = Array.new(4)
	#создаем массив с картами игрока и картами на столе
	igrok = Array.new(2)
	stol = Array.new(5)
	#создаем массив для комбинаций
	komboArray = Array.new(7)
	kombo=Array.new
	puts "Введите название комбинации, или нажмите Enter, чтобы продолжить"
	begin_time = Time.now
	#komanda = gets.chomp
	komanda = "Стрит"
	if komanda == ""
		k=poker.razdacha(koloda, igrok, stol, poker, komanda, kombo)

	else
		flag = true
		iter = 0
		while flag
			iter+=1
			if komanda == poker.razdacha(koloda, igrok, stol, poker, komanda, kombo)
				k=komanda
				flag = false
				time = Time.now - begin_time
			end
		end
	end
		#выводим карты на консоль
		puts "Карты игрока: " + igrok.to_s
		puts "Карты на столе: " + stol.to_s
		puts k
		kombina = Array.new
		kombo.each do |i|
			kombina << poker.preobraz(i[0],i[1])
		end
		puts kombina.to_s
		puts "Кол-во итераций ="+ iter.to_s
		puts "Время выполнения "+ time.to_s
end