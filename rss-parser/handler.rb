require 'rss'
require 'open-uri'

class Handler
  def run(req)
    parse_rss
  end

  def parse_rss
    # Set up the output RSS feed
    rss = RSS::Maker.make("atom") do |maker|
      maker.channel.author = "reylo_fic"
      maker.channel.updated = Time.now.to_s
      maker.channel.title = "reylo fics"
      maker.channel.about = "reylo_fic on twitter"

      # Read the input RSS feed
      url = ENV['reylo_rss_feed']
      URI.open(url) do |url|
        feed = RSS::Parser.parse(url)
        # loop through each item in the input feed and set up values we'll be using in the output RSS feed
        feed.items.each do |item|
          # for some reason there are a lot of large spaces with the way this code reads the input RSS feed so we have to strip the extra spaces
          title = item.title.gsub(/\s+/, " ")
          link = item.link
          # Replace all "</p>" tags with a space before stripping the rest of the HTML tags
          description = item.description.gsub(/<\/p>/, " ").gsub(/<\/?[^>]*>/, "")
          # rating is hacky; take the first character from the input feed's dc_creator field
          rating = item.dc_creator[0]
          # now put it all together
          msg ="#{title} (#{rating})\n#{link}\n#{description}"
          # it is almost guaranteed that there will be >280 characters in msg so truncate it gracefully
          if msg.length > 280
            msg = msg.slice(0..272).chomp("\s")
            msg = "#{msg}..."
          end
          # now format the entry for the output RSS feed
          maker.items.new_item do |new_item|
            new_item.link = link
            new_item.title = title
            new_item.date = Time.now.to_s
            new_item.description = msg
          end
        end
      end
    end
    return rss
  end
end