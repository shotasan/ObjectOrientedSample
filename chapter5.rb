# class Japanese;end
# class English;end
# class French;end

# クラスで分岐するcase文
# class Hoge
#   def greeting(langs)
#     langs.each do |lang|
#       case lang
#       when Japanese
#         puts "こんにちは"
#       when English
#         puts "Hello"
#       when French
#         puts "Bonjour"
#       end
#     end
#   end
# end

# hoge = Hoge.new
# hoge.greeting([Japanese.new, English.new, French.new])

# ダックタイピング?
class Hoge
  def greeting(langs)
    langs.each { |lang| lang.greet(self) }
  end
end

class Japanese
  def greet(lang)
    puts "こんにちは"
  end
end

class English
  def greet(lang)
    puts "Hello"
  end
end

class French
  def greet(lang)
    puts "Bonjour"
  end
end

hoge = Hoge.new
hoge.greeting([Japanese.new, English.new, French.new])