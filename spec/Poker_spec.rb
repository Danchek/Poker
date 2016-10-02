require "/home/denis/Poker/spec/spec_helper"
describe Poker do
	poker = NewGame.new
	komanda = "Стрит"
	koloda = Array.new(4)
	#создаем массив с картами игрока и картами на столе
	igrok = Array.new(2)
	stol = Array.new(5)
	kombo=Array.new
	a=2
	b=4

	describe "#razdacha" do
		it "returns name of combination" do
			expect(poker.razdacha(koloda, igrok, stol, poker, komanda, kombo)).not_to be_empty
			expect(kombo).not_to be_empty
		end
	end

	describe "#preobraz" do
		it "Converts index of cards to it's name" do
			expect_value = "6C"
			expect(poker.preobraz(a,b)).to eq(expect_value)
		end
	end

	describe "#kombo" do
		it "returns name of combination" do
			expect(poker.razdacha(koloda, igrok, stol, poker, komanda, kombo)).not_to be_empty
			expect(kombo).not_to be_empty
		end
	end
end
