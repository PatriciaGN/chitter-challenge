require 'maker'
require 'maker_repository'

def reset_makers_table
  seed_sql = File.read('spec/seeds/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_database_test'})
  connection.exec(seed_sql)
end

describe MakerRepository do
  before(:each) do
    reset_makers_table
  end

  describe '#all' do
    it 'finds all makers' do
      repo = MakerRepository.new

      makers = repo.all

      expect(makers.length).to eq(2)
      expect(makers.first.id).to eq(1)
      expect(makers.first.name).to eq('Ruby')
      expect(makers.first.username).to eq('cute-cat')
      expect(makers.first.email).to eq('ruby1@gmail.com')
      expect(makers.first.password).to eq('12345')
    end
  end

  describe '#find' do
    it 'finds one maker by id' do
      repo = MakerRepository.new
      maker = repo.find(1)

      expect(maker.id).to eq(1)
      expect(maker.name).to eq('Ruby')
      expect(maker.username).to eq ('cute-cat')
      expect(maker.email).to eq('ruby1@gmail.com')
      expect(maker.password).to eq('12345') 
    end

    it 'finds maker with id 2' do
      repo = MakerRepository.new
      maker = repo.find(2)

      expect(maker.id).to eq(2)
      expect(maker.name).to eq('Amethist')
      expect(maker.username).to eq('foxlover')
      expect(maker.email).to eq('ameth22@gmail.com')
      expect(maker.password).to eq('123456') 
    end
  end

  describe '#create' do
    it 'creates a maker' do
      repo = MakerRepository.new
      maker = Maker.new
      maker.name = 'Dan'
      maker.username = 'seal-doctor'
      maker.email = 'marinevet@gmail.com'
      maker.password = '23896'
      repo.create(maker)

      makers = repo.all
      
      expect(makers.length).to eq(3)
      expect(makers.last.id).to eq(3)
      expect(makers.last.name).to eq('Dan')
      expect(makers.last.username).to eq('seal-doctor')
      expect(makers.last.email).to eq('marinevet@gmail.com')
      expect(makers.last.password).to eq('23896')
    end
  end
end