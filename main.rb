require 'telegram/bot'

TOKEN = 'xxx'


def reader(type)
  current_path = File.dirname(__FILE__)

    if type == 1
      file_path = "rasp1.txt"

    elsif type == 2
      file_path = "rasp2.txt"

    else
      puts "Файл не найден"
    end

  if File.exist?(file_path)
    f = File.new(file_path, "r:UTF-8")
    lines = f.readlines
    f.close
    return "сегодня трудятся #{lines[0]}\nзавтра трудятся #{lines[1]}"
  else
    return "Файл не найден или протух - посмотри расписание в вики"
  end
end


Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Привет, #{message.from.first_name}. 1 или  2?"
        )
    when 'a2p', '1'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "#{reader(1)}"
      )
    when 'content', '2'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "#{reader(2)}"
      )
    else
      bot.api.send_message(
        chat_id: message.chat.id,
        text: ' 1 или  2?'
        )
    end
  end
end
