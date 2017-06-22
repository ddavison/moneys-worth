module Steam

  require 'open-uri'

  NEWS ='ISteamNews'
  USER = 'ISteamUser'
  USER_STATS = 'ISteamUserStats'
  PLAYER_SERVICE = 'IPlayerService'

  def self.steamid_from_vanity(user)
    fetch(USER, 'ResolveVanityURL/v0001', {vanityurl: user})['response']['steamid']
  end

  def self.get_games_for(steamid)
    fetch(PLAYER_SERVICE, '/GetOwnedGames/v0001', {steamid: steamid})['response']['games']
  end

  def self.get_game_information(appid)
    if Game.where('appid = ?', appid).any?
      Game.find_by_appid(appid)
    else
      res = fetch(USER_STATS, 'GetSchemaForGame/v2', {appid: appid})
      info = JSON.parse(open("http://store.steampowered.com/api/appdetails?appids=#{appid}").read)

      begin
        short_description = info[appid.to_s]['data']['short_description'] || ''
        price = info[appid.to_s]['data']['price_overview']['initial'] || ''
      rescue NoMethodError
        short_description = ''
        price = 0
      end

      Game.create(
          appid: appid,
          name: res['game']['gameName'],
          short_description: short_description,
          price: price
      )
    end
  end

  def self.image_url_for_game(appid)
    "http://steampowered.com/v/gfx/apps/#{appid}/header.jpg"
  end

  private
  def self.fetch(api, url, params='')
    url = "http://api.steampowered.com/#{api}/#{url}?key=#{Settings.steam.api_key}&format=json#{params.map { |x, v| "&#{x}=#{v}" }.reduce { |x, v| "#{x}&#{v}" } if params != ''}"
    puts "fetching #{url}"
    JSON.parse(open(url).read)
  end
end
