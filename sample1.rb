# -*- mode:ruby; coding:utf-8 -*-
# ナマケモノ育成ゲーム

vitality = 10	# 体力
mental = 10	# 機嫌度
cmd = ""	# 世話コマンド
food, clean, out, sleep = 0, 0, 0, 0	# 世話フラグかつサボり日数(略してセワサボ)

# 7日間預かり、8日目に返す
puts "ナマケモノを預かることになりました。"
7.times { | day |
	print day+1,"日目です\n"
	# セワサボ加算
	food += 1
	clean += 1
	out += 1
	sleep += 1
	4.times { | action |
		print "どの世話をしますか？ (f.食事/c.掃除/o.散歩/s.睡眠) =>"
		cmd = gets.chomp	# コマンドは数字でなく文字にしました

		# 世話したらそれぞれのセワサボをゼロに戻す
		case cmd
			when "f"
				puts "エサを与えました。"
				vitality +=2
				food = 0
			when "c"
				puts "掃除をしました。"
				vitality -=1
				mental -=1
				clean = 0
			when "o"
				puts "散歩に出ました。"
				vitality -=1
				mental +=1
				out = 0
			when "s"
				puts "寝かしつけました。"
				vitality -=2
				mental +=2
				sleep = 0
			else
				puts "コマンドが違います"
				redo	# ミス入力はループやり直し
		end
		# 世話失敗したら強制終了
		if vitality < 1 || mental < 1
			break
		end
	}
	# 強制終了の場合セワサボの判定もしない
	if vitality < 1 || mental < 1
		break
	end
	# セワサボ判定
	# サボればサボるほど満腹度や機嫌度が激しく減少
	if food > 0
		vitality -=3 * food
		puts "お腹がすいているようです"
	end
	if clean > 0
		mental -=1 * clean
		puts "掃除をしましょう"
	end
	if out > 0
		mental -=1 * clean
		puts "散歩に連れてってあげましょう"
	end
	if sleep > 0
		mental -=3 * sleep
		puts "眠たそうです"
	end
	# 世話失敗したら強制終了
	if vitality < 1 || mental < 1
		break
	end
	# 日時レポート
	if day<7
		print day+1,"日目が終わりました\n"
		print "---------------------\n"
		print "満腹度: ",vitality," 機嫌度: ",mental,"\n"
		print "---------------------\n\n"
	end
}

# 終了
if vitality >0 && mental > 0
	puts "無事にナマケモノを返すことができました"
else
	if vitality < 1
		puts "かわいそうに。ナマケモノは死んでしまいました。"
	end
	if mental < 1
		puts "世話をしてくれないのでナマケモノは逃げてしまいました。"
	end
end
