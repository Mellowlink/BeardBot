bot_data = Dir.glob("lib/beardbot/*")

BEARDBOT = ProgramR::Facade.new
BEARDBOT.learn(bot_data)
