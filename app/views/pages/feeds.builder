# frozen_string_literal: true

xml.instruct!
xml.rss version: '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title 'Ізюмська фортеця'
    xml.description 'Історія ізюмської фортеці та Ізюмщини'
    xml.link root_url
    xml.language 'uk'

    Post.published.each do |post|
      xml.item do
        xml.title post.title
        xml.link post_url(:uk, post)
        xml.pubDate(post.created_at.rfc2822)
        xml.guid post_url(post)
        xml.description(h(strip_tags(post.body.to_s).truncate(200)))
        xml.category 'Статті'
      end
    end

    Personality.published.each do |personality|
      xml.item do
        xml.title personality.name
        xml.link personality_url(:uk, personality)
        xml.pubDate(personality.created_at.rfc2822)
        xml.guid personality_url(:uk, personality)
        xml.description(h(personality.information).truncate(200))
        xml.category 'Особистості'
      end
    end

    xml.item do
      xml.title 'Мапа 1740 року'
      xml.link map_1740_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_1740_maps_url
      xml.description 'Мапа 1740 року'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа 1752 року'
      xml.link map_1752_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_1752_maps_url
      xml.description 'Мапа 1752 року'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа 1760 року'
      xml.link map_1761_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_1761_maps_url
      xml.description 'Мапа 1760 року'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа 1766 року'
      xml.link map_1766_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_1766_maps_url
      xml.description 'Мапа 1766 року'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа 1768 року'
      xml.link map_1768_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_1768_maps_url
      xml.description 'Мапа 1768 року'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа 1770 року'
      xml.link map_1770_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_1770_maps_url
      xml.description 'Мапа 1770 року'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа 1782 року'
      xml.link map_1782_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_1782_maps_url
      xml.description 'Мапа 1782 року'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа 1787-1786 років'
      xml.link map_1787_1786_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_1787_1786_maps_url
      xml.description 'Мапа 1787-1786 років'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа 1845 року'
      xml.link map_1845_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_1845_maps_url
      xml.description 'Мапа 1845 року'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Креслення Московських та Кримських воріт'
      xml.link map_moscovian_crimean_gates_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_moscovian_crimean_gates_maps_url
      xml.description 'Креслення Московських та Кримських воріт'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа невідомого року'
      xml.link map_unknown_year_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_unknown_year_maps_url
      xml.description 'Мапа невідомого року'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа невідомого року 2'
      xml.link map_unknown_year_2_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_unknown_year_2_maps_url
      xml.description 'Мапа невідомого року 2'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Мапа невідомого року 3'
      xml.link map_unknown_year_3_maps_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid map_unknown_year_3_maps_url
      xml.description 'Мапа невідомого року 3'
      xml.category 'Мапи'
    end

    xml.item do
      xml.title 'Порявняння 1782-1943 років'
      xml.link comparison_1782_1943_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid comparison_1782_1943_url
      xml.description 'Порявняння 1782-1943 років'
      xml.category 'Порівняння'
    end

    xml.item do
      xml.title 'Порявняння 1845-1943 років'
      xml.link comparison_1845_1943_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid comparison_1845_1943_url
      xml.description 'Порявняння 1845-1943 років'
      xml.category 'Порівняння'
    end

    xml.item do
      xml.title 'Порявняння 1943-2017 років'
      xml.link comparison_1943_2017_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid comparison_1943_2017_url
      xml.description 'Порявняння 1943-2017 років'
      xml.category 'Порівняння'
    end

    xml.item do
      xml.title 'Порявняння 1782-2017 років'
      xml.link comparison_1782_2017_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid comparison_1782_2017_url
      xml.description 'Порявняння 1782-2017 років'
      xml.category 'Порівняння'
    end

    xml.item do
      xml.title 'Порявняння 1845-2017 років'
      xml.link comparison_1845_2017_url
      xml.pubDate Date.new(2020, 5, 14)
      xml.guid comparison_1845_2017_url
      xml.description 'Порявняння 1845-2017 років'
      xml.category 'Порівняння'
    end
  end
end
