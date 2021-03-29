class Game < ApplicationRecord
  enum turn: %i[player_x player_o]
  enum status: %i[in_progress tie win_x win_o]

  def move
  end

  def play(input)
    position = input.to_i
    unless board[position - 1] == '.'
      errors.add(:board, 'invalid move, position already taken')
      return
    end

    if player_x?
      board[position - 1] = 'X'
      if winner?(position)
        self.status = :win_x
      elsif tie?
        self.status = :tie
      else
        self.turn = :player_o
      end
    else
      board[position - 1] = 'O'
      if winner?(position)
        self.status = :win_o
      elsif tie?
        self.status = :tie
      else
        self.turn = :player_x
      end
    end
    save!
  end

  private

  def tie?
    board.chars.exclude?('.')
  end

  def winner?(position)
    case position
    when 1
      row1? || col1? || diag1?
    when 2
      row1? || col2?
    when 3
      row1? || col3? || diag2?
    when 4
      row2? || col1?
    when 5
      row2? || col2? || diag1? || diag2?
    when 6
      row2? || col3?
    when 7
      row3? || col1? || diag2?
    when 8
      row3? || col2?
    when 9
      row3? || col3? || diag1?
    end
  end

  def row1?
    board[0] == board[1] && board[1] == board[2]
  end

  def row2?
    board[3] == board[4] && board[4] == board[5]
  end

  def row3?
    board[6] == board[7] && board[7] == board[8]
  end

  def col1?
    board[0] == board[3] && board[3] == board[6]
  end

  def col2?
    board[1] == board[4] && board[4] == board[7]
  end

  def col3?
    board[2] == board[5] && board[5] == board[8]
  end

  def diag1?
    board[0] == board[4] && board[4] == board[8]
  end

  def diag2?
    board[2] == board[4] && board[4] == board[6]
  end
end
