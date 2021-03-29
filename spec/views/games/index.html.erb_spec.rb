require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(
        turn: 2,
        status: 3
      ),
      Game.create!(
        turn: 2,
        status: 3
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
