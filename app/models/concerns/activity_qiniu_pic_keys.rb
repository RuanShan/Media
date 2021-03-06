module Concerns::ActivityQiniuPicKeys
  #vip=FitJY1_Agsv5V9W5-dH-M5FVUM0E
  #gua=Fkgsh_bQL0bVzzB--_vlgXh_XEg-
  #fight=FknTGEgpxbPd-N0LhujFkAbVObEZ
  #wheel=Fl-25j4H93sfZ-B0ouwCusJfXK7D
  #enroll=Fq3yau2in3gxC15TcsIrImIDFbdw
  #groups=FmPmG9Qi9qkBTGEQrcY70jGxiQ4w
  #life=FpYCG7QI2N5s0L2MJoebLs96pQV2
  #circle=Fg7y_-6AMUi3vRFmtULpqE4s8D-w
  #slot=FmP_AWEx35d2zhFnIXx_55aaDMkS
  #booking=FsbEJWQgWNg7Ga5S8A2UGB54EDqA
  #business_shop=Fg7y_-6AMUi3vRFmtULpqE4s8D-w
  #shake=FhnW0qwKkTC4uxMV1ZwY2niFf4of
  #coupon=FnoIyiqaGaYVViwiEqHImqmnqC7C
  #reservation=FocY5CovSW0PpjozyeEcnM-1bMQV
  #wave=FiALiRQKq-vTYiIXbS6IAivM_8Vx
  #fans_game=FqevqsHf1cxzyBlxLd3gJL6M3LRV
  #recommend=FvKlSn2sj3mov1njd3sJs5mZ6Es9
  #unfold=FpTTvgANcRl0it7NzhQk745N4ZJx
  #scene=FneRCw-FhBJ2iB6bQ1KaQCsG4kwV
  #guess=Fjm04tDsI6TcKNbWFMsrugyUVjdx
  #wx_card=FsRRrPGYKkTga6uZf5dqEq213IBT
  #brokerage=FqrqdYm_6c4ih0EGQ1rcEUMLtdlB
  #red_packet=FtyH1xI2Y61WKdpIeJO196XTKy-p
  #micro_aid=FmkcCvuv-qfnVgT3prcxrkHCFYds

  KEY_MAPS = {
    ActivityType::VIP              => "FitJY1_Agsv5V9W5-dH-M5FVUM0E",
    ActivityType::GUA              => "Fkgsh_bQL0bVzzB--_vlgXh_XEg-",
    ActivityType::FIGHT            => "FknTGEgpxbPd-N0LhujFkAbVObEZ",
    ActivityType::WHEEL            => "Fl-25j4H93sfZ-B0ouwCusJfXK7D",
    ActivityType::ENROLL           => "Fq3yau2in3gxC15TcsIrImIDFbdw",
    ActivityType::MICRO_STORE      => "FjxNnverrDCafh3MuK05eqDv2SLD",
    ActivityType::VOTE             => "Fr_PWSHvO_toLXePQlM9yFdYU6qC",
    ActivityType::HOUSE            => "FtKIozMXq2WGzJZDshqgvlZyy8hZ",
    ActivityType::GROUPS           => "FmPmG9Qi9qkBTGEQrcY70jGxiQ4w",
    ActivityType::SURVEYS          => "FrbfVtC7JBUX4txHaxK_4-eYxZfI",
    ActivityType::CAR              => "FmqN7v23GIJnuLb-kRpL99MyMA2F",
    ActivityType::WEDDINGS         => "FretXhlUTwOSSslPedx1m6DS3xUo",
    ActivityType::HOTEL            => "Fp924zYcTtlE7w0zypGX7_nYgI-J",
    ActivityType::ALBUM            => "FiXhM7sRU8Mu9Qf5Vc_OUauArbL9",
    ActivityType::EDUCATIONS       => "FnHKupgPSyWOtO3tgqCH75j0nUue",
    ActivityType::LIFE             => "FpYCG7QI2N5s0L2MJoebLs96pQV2",
    # ActivityType::EC               => "Fh0igUatVyi2TvekIIHaVRNnwJVD",
    ActivityType::CIRCLE           => "Fg7y_-6AMUi3vRFmtULpqE4s8D-w",
    ActivityType::MESSAGE          => "FgGJjMn1S0ew85Z2OnPqd2Z8W8jP",
    ActivityType::HOUSE_BESPEAK    => "FsGbyCS8yjRmbxWMkDduSdKAKsGi",
    ActivityType::HOUSE_SELLER     => "FlcZr6734s-BiXD-a35MyxGI_yRx",
    ActivityType::SLOT             => "FmP_AWEx35d2zhFnIXx_55aaDMkS",
    ActivityType::BOOKING          => "FsbEJWQgWNg7Ga5S8A2UGB54EDqA",
    ActivityType::HOSPITAL         => "FoZWEvFw-1v5aRGdnmnus4ytiqBk",
    ActivityType::TRIP             => "Fjcw7LfeW9meLcoLYyshnlSv0Vzz",
    ActivityType::BUSINESS_SHOP    => "Fg7y_-6AMUi3vRFmtULpqE4s8D-w",
    ActivityType::HOUSE_IMPRESSION => "FtKIozMXq2WGzJZDshqgvlZyy8hZ",
    ActivityType::HOUSE_LIVE_PHOTO => "FtKIozMXq2WGzJZDshqgvlZyy8hZ",
    ActivityType::HOUSE_REVIEW     => "FtKIozMXq2WGzJZDshqgvlZyy8hZ",
    ActivityType::HOUSE_INTRO      => "FtKIozMXq2WGzJZDshqgvlZyy8hZ",
    ActivityType::KTV_ORDER        => "FkEQMneloG3i6iQydjSGjF7AnoWF",
    ActivityType::WBBS_COMMUNITY   => "Fs-PYHxM00Gs8vzy2l4m1gaHVmZj",
    ActivityType::DONATION         => "Fn1jFqncjU8moXi3ZkstMeTOCnrI",
    ActivityType::SHAKE            => "FhnW0qwKkTC4uxMV1ZwY2niFf4of",
    ActivityType::COUPON           => "FnoIyiqaGaYVViwiEqHImqmnqC7C",
    ActivityType::RESERVATION      => "FocY5CovSW0PpjozyeEcnM-1bMQV",
    ActivityType::WAVE             => "FiALiRQKq-vTYiIXbS6IAivM_8Vx",
    ActivityType::FANS_GAME        => "FqevqsHf1cxzyBlxLd3gJL6M3LRV",
    ActivityType::GOVMAIL          => "FncFoDKaUlCnbPpUrCBRrcZF0iD7",
    ActivityType::GOVCHAT          => "FozsCIEKSeaHAeHVwRyP5IJyMcEK",
    ActivityType::RECOMMEND        => "FvKlSn2sj3mov1njd3sJs5mZ6Es9",
    ActivityType::UNFOLD           => "FpTTvgANcRl0it7NzhQk745N4ZJx",
    ActivityType::SCENE            => "FneRCw-FhBJ2iB6bQ1KaQCsG4kwV",
    ActivityType::PANORAMAGRAM     => "FoP2wsQa60NeDs1TnFisdg8vy1c6",
    ActivityType::GUESS            => "Fjm04tDsI6TcKNbWFMsrugyUVjdx",
    ActivityType::WX_CARD          => "FsRRrPGYKkTga6uZf5dqEq213IBT",
    ActivityType::BROKERAGE        => "FqrqdYm_6c4ih0EGQ1rcEUMLtdlB",
    ActivityType::RED_PACKET       => "FtyH1xI2Y61WKdpIeJO196XTKy-p",
    ActivityType::MICRO_AID        => "FmkcCvuv-qfnVgT3prcxrkHCFYds",
  }

  class << self
    def default_site_pic_qiniu_key
      'FlL1C_QEO1l-6TwumUieLdO8kjKN'
    end
  end
end
