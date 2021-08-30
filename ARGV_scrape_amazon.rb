#!/usr/bin/env ruby
#-*- coding: utf-8 -*-

#webに接続するためのライブラリ
require "open-uri"
#クレイピングに使用するライブラリ
require "nokogiri"

require 'pry'

# def scrape_amazon(asin)
  #クレイピング対象のURL
  url = "https://www.amazon.co.jp/dp/#{ARGV[0]}"

  #User-Agentで偽装
  opt = {}
  opt['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36'

  #取得するhtml用charset
  charset = nil

  html = open(url, opt) do |page|
    #charsetを自動で読み込み、取得
    charset = page.charset
    #中身を読む
    page.read
  end

  # Nokogiri で切り分け
  contents = Nokogiri::HTML.parse(html,nil,charset)

  #この商品についてが含まれるdivを取得
  parent = contents.at_css('#hsx-rpp-bullet-fits-message').parent

   #この商品についてが含まれるリストを取得
  list = parent.css('li')

  #最初の不要なliを削除
  list.shift

  list.each do |node|
    puts node.text
  end

  # puts text
# end