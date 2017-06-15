require 'gilded_rose'
require 'item'

describe GildedRose do

  context "Standard Item" do
    describe "#update_quality" do
      before :all do
        items = [
          Item.new("+5 Dexterity Vest", 10, 20),
          Item.new("Boar Meat", -1, 10),
          Item.new("Shoddy dagger", 0, 0)
        ]
        @gilded_rose = GildedRose.new(items)
        @gilded_rose.update_quality
      end

      it "does not change the name" do
        expect(@gilded_rose.items[0].name).to eq "+5 Dexterity Vest"
      end

      it "decreases in value at standard rate" do
        expect(@gilded_rose.items[0].quality).to eq 19
      end

      it "decreases in value at double rate when sell-by-date is passed" do
        expect(@gilded_rose.items[1].quality).to eq 8
      end

      it "value can't go negative" do
        expect(@gilded_rose.items[2].quality).to eq 0
      end

      context "Aged Brie" do
        describe "#update_quality" do
          before :all do
            items = [
              Item.new("Aged Brie", 2, 0)
            ]
            @gilded_rose = GildedRose.new(items)
            @gilded_rose.update_quality
          end

          it "increases in value over time" do
            expect(@gilded_rose.items[0].quality).to eq 1
          end

          it "increases in value at double rate when sell by date is passed" do
            @gilded_rose.update_quality
            @gilded_rose.update_quality
            expect(@gilded_rose.items[0].quality).to eq 4
          end



        end
      end
    end
  end
end
