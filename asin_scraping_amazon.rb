#!/usr/bin/env ruby
#-*- coding: utf-8 -*-

#webに接続するためのライブラリ
require "open-uri"
#クレイピングに使用するライブラリ
require "nokogiri"

require 'pry'

def scraping_amazon(asin)
  #クレイピング対象のURL
  url = "https://www.amazon.co.jp/dp/" + asin

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

  parent = contents.at_css('#hsx-rpp-bullet-fits-message').parent

  list = parent.css('li')

  #最初のliを削除
  list.shift

  #文字列を収納する配列を初期化
  array = []

  list.each do |node|
    #テキスト部分を代入
    array.push(node.text)
  end

  return array

end

puts scraping_amazon('B004MKNE5C')