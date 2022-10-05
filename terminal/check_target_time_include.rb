# frozen_string_literal: true

require './target_time_include'

# シェル操作を行う場合
valid_range = Range.new(0, 23)
pattern = /[0-9]/

puts '開始時刻を入力してください'
while true
  start = gets.chomp # ユーザーの入力

  if start.match(pattern)
    start = start.to_i
  else
    puts '数値で入力してください'
    redo
  end

  break if valid_range.include?(start)

  puts '0~23の範囲で入力してください'
end

puts '終了時刻を入力してください'
while true
  finish = gets.chomp # ユーザーの入力
  if finish.match(pattern)
    finish = finish.to_i
  else
    puts '数値で入力してください'
    redo
  end

  break if valid_range.include?(finish)

  puts '0~23の範囲で入力してください'
end

puts '確認したい時刻入力してください'
while true
  target = gets.chomp # ユーザーの入力

  if target.match(pattern)
    target =  target.to_i
  else
    puts '数値で入力してください'
    redo
  end

  break if valid_range.include?(target)

  puts '0~23の範囲で入力してください'
end

p TargetTimeInclude.new(start, finish, target).included?
