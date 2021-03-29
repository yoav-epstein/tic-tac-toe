FactoryBot.define do
  factory :game do
    turn { :player_x }
    status { :in_progress }
    board { '.........' }
  end
end
