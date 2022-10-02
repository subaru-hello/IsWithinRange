# frozen_string_literal: true

class TargetTimeCheck
  attr_reader :target_time, :start_time, :finish_time

  def initialize(start_time, finish_time, target_time)
    remove_redundant_zero(start_time, finish_time, target_time)

    @start_time = start_time
    @finish_time = finish_time
    @target_time = target_time
  end

  # public interface
  def included?
    puts "#{target_time}時は#{start_time}時~#{finish_time}時の間に"

    return '含まれます' if within_valid_range?

    '含まれません'
  end

  private


  # 01や002などの数を正規表現で1や2に変換する
  def remove_redundant_zero(*time)
    time.map do |param_time|
      param_time.to_s.gsub!(/([^\d]?)0+(\d+)/, '\1\2')
    end
    time
  end

  # 日を跨いでいるかどうか確認
  def remainder
    start_time - finish_time
  end

  # 日を跨いでいない場合の範囲
  def times_between_start_to_finish
    Range.new(start_time, finish_time, true)
  end

  # 日を跨いでいる場合の範囲
  def times_from_zero_to_finish
    Range.new(0, finish_time, true)
  end

  def times_from_start_to_eleven_pm
    Range.new(start_time, 23)
  end

  # 開始時間と確認したい時間が同じだと必ずtrueになる
  def start_time?
    start_time.eql? target_time
  end
  
  # 日を跨いでいるかチェックするメソッド
  def not_across_the_day?
    times_between_start_to_finish.include?(target_time)
  end

  def across_the_day?
    times_from_zero_to_finish.include?(target_time) || times_from_start_to_eleven_pm.include?(target_time)
  end

  # 時間が開始と終了の範囲内にあるかチェックするメソッド
  def within_valid_range?
    return start_time? if remainder.zero?
    return not_across_the_day? if remainder.negative?
    return across_the_day? if remainder.positive?
  end
end

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

p TargetTimeCheck.new(start, finish, target).included?
