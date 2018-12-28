RSpec.describe Hero::Gcivic do
  before(:each) do
    @key=ENV['API_KEY']
    @client=Hero::Gcivic::Client.new(api_key: @key)
  end

  it "has a version number" do
    expect(Hero::Gcivic::VERSION).not_to be nil
  end

  it 'reps' do
    address="300 Bryant Street NW,Washington,DC,20001"


    puts @client.representatives(address: address).body
  end

  it "reps by ocdid" do
    ocdid="ocd-division/country:us/state:wa"
    #ocdid="ocd-division/country:us/state:wa/county:king"
    resp=JSON.parse(@client.representatives(ocdid: ocdid, recursive: true).body)

    # divisions, offices, officials
    #city	state	zip	party	phones	urls	emails

    rows=@client.representative_rows(resp)
    csv=@client.representative_csv(rows)

    File.open("tmp/reps.csv",'w') {|f| f.write(csv)}
    pp csv


  end

  it "gets divisions" do
    divisions=JSON.parse(@client.divisions().body)['results']
    pp divisions
    puts divisions.count
  end
end
