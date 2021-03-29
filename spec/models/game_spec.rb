require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#play' do
    subject { game.play(input) }

    let(:game) { create(:game, board: board) }
    let(:input) { '1' }
    let(:board) { '.........' }

    it 'updates the board' do
      expect { subject }.to change { game.board }.from(board).to('X........')
    end

    it 'changes the turn' do
      expect { subject }.to change { game.turn }.from('player_x').to('player_o')
    end

    context 'game is won by' do
      let(:board) { '.XX......' }

      it 'changes the status to a win_x' do
        expect { subject }.to change { game.status }.from('in_progress').to('win_x')
      end
    end

    context 'turn is for player o' do
      before do
        game.turn = :player_o
      end

      it 'updates the board' do
        expect { subject }.to change { game.board }.from(board).to('O........')
      end

      it 'changes the turn' do
        expect { subject }.to change { game.turn }.from('player_o').to('player_x')
      end

      context 'game is won' do
        let(:board) { '.OO......' }

        it 'changes the status to a win_x' do
          expect { subject }.to change { game.status }.from('in_progress').to('win_o')
        end
      end
    end

    context 'game is a tie' do
      let(:board) { '.XOOOXXOX' }

      it 'changes the status to a tie' do
        expect { subject }.to change { game.status }.from('in_progress').to('tie')
      end
    end

    context 'position is already in use' do
      let(:board) { 'O........' }

      it 'adds an error' do
        expect { subject }.to change { game.errors.size }.by(1)
      end

      it 'does not change the board' do
        expect { subject }.to_not change { game.board }
      end

      it 'changes the turn' do
        expect { subject }.to_not change { game.turn }
      end
    end
  end
end
