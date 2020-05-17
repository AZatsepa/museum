# frozen_string_literal: true

# Change this to your host. See the readme at https://github.com/lassebunk/dynamic_sitemaps
# for examples of multiple hosts and folders.
host 'https://izyum-fortress.in.ua'

sitemap :izyum_fortress do
  url root_url, last_mod: Time.now, change_freq: 'daily', priority: 1.0

  url posts_url
  Post.published.each do |post|
    url post_url(:uk, post), last_mod: post.updated_at
  end

  personalities_url
  Personality.published.each do |personality|
    url personality_url(:uk, personality), last_mod: personality.updated_at
  end

  url maps_url
  url map_1740_maps_url
  url map_1752_maps_url
  url map_1761_maps_url
  url map_1766_maps_url
  url map_1768_maps_url
  url map_1770_maps_url
  url map_1782_maps_url
  url map_1786_maps_url
  url map_1787_1786_maps_url
  url map_1845_maps_url
  url map_1910_maps_url
  url map_moscovian_crimean_gates_maps_url
  url map_unknown_year_maps_url
  url map_unknown_year_2_maps_url
  url map_unknown_year_3_maps_url

  url comparison_url
  url comparison_1782_1943_url
  url comparison_1845_1943_url
  url comparison_1943_2017_url
  url comparison_1782_2017_url
  url comparison_1845_2017_url
end

ping_with 'https://izyum-fortress.in.ua/sitemap.xml'
