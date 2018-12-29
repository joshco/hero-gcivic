RSpec.describe "Tool" do

  it "gets divisions for form" do
    tool=Hero::Gcivic::Tool.new
    divisions=tool.divisions
    pp divisions
  end
end