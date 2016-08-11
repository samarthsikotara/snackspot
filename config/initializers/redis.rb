ENV["REDISTOGO_URL"] ||= "redis://redistogo:bc3e063d5b9bfca5e09aec2d884b1e4f@lab.redistogo.com:9543/"
uri = URI.parse(ENV["REDISTOGO_URL"])

$redis = Redis.new(:url => uri)