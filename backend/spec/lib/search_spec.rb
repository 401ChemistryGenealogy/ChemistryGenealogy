require_relative '../../app/lib/search.rb'

describe Search do
  it "is instantiable" do
    @search = Search.new()
    expect(@search).not_to eql(nil)
  end


end