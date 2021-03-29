require 'rails_helper'

RSpec.describe 'playing a game', type: :feature do
  def move(position)
    fill_in 'Move', with: position
    click_on 'Update Game'
  end

  it 'alternates turns' do
    visit root_path

    click_on 'New Game'
    expect(page).to have_content('Enter Position for X')

    move(5)
    expect(page).to have_content('Enter Position for O')

    move(1)
    expect(page).to have_content('Enter Position for X')
  end

  it "doesn't allow the use the same space" do
    visit root_path

    click_on 'New Game'
    expect(page).to have_content('Enter Position for X')

    move(5)
    expect(page).to have_content('Enter Position for O')

    move(5)
    expect(page).to have_content('Enter Position for O')
    expect(page).to have_content('invalid move, position already taken')

    move(4)
    expect(page).to have_content('Enter Position for X')
  end

  it 'shows a tied game' do
    visit root_path

    click_on 'New Game'
    expect(page).to have_content('...')

    move(1)
    expect(page).to have_content('X..')

    move(5)
    expect(page).to have_content('.O.')

    move(2)
    expect(page).to have_content('XX.')

    move(3)
    expect(page).to have_content('XXO')

    move(7)
    expect(page).to have_content('X..')

    move(4)
    expect(page).to have_content('OO.')

    move(6)
    expect(page).to have_content('OOX')

    move(8)
    expect(page).to have_content('XO.')

    move(9)
    expect(page).to have_content('Status: tie')
    expect(page).to have_content('XXO')
    expect(page).to have_content('OOX')
    expect(page).to have_content('XOX')
  end

  it 'shows a winning game' do
    visit root_path

    click_on 'New Game'
    expect(page).to have_content('...')

    move(5)
    expect(page).to have_content('.X.')

    move(4)
    expect(page).to have_content('OX.')

    move(1)
    expect(page).to have_content('X..')

    move(9)
    expect(page).to have_content('..O')

    move(3)
    expect(page).to have_content('X.X')

    move(2)
    expect(page).to have_content('XOX')

    move(7)
    expect(page).to have_content('Status: win_x')
    expect(page).to have_content('XOX')
    expect(page).to have_content('OX.')
    expect(page).to have_content('X.O')
  end

end
