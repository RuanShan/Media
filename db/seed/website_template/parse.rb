require 'nokogiri'
require 'open-uri'

def parse_template_html
  file = "view-source_winwemedia.com_website_settings.html"
  path = File.expand_path( file, File.dirname(__FILE__))


  doc = Nokogiri::HTML(open(path).read)

  puts "### Search for nodes by css"
  #['home_template', 1, '首页模板'],
  #['list_template', 2, '列表页模板'],
  #['detail_template', 3, '详情页模板'],
  #['navigation', 4, '导航栏模板'],
  #['menu', 5, '快捷菜单模板'],
  (1..5).each{|i|
    puts "## Start template type #{i}"
    doc.css("li[template_type='#{i}']").each_with_index do |li,i|
      attrs = {
        style_index: li['template_id'],
        template_type: li['template_type'],
        website_tag_id: li['tag_id'],
        is_boutique: li['boutique']=='true',
        name: li['name'],
        sort: i+1,
        #website_tag_name: li['website_tag_name'],
        description: li['description'],
        support_bg_image: li['support_bg_image_name']=='支持', #背景图
        support_slide: li['support_slide_name']=='支持',       #幻灯片
        support_ws_logo: li['support_ws_logo_name']=='支持',   #微官网Logo
        support_wm_pic: li['support_wm_pic_name']=='支持',     #站点标题图
        support_bg_music: li['support_bg_music_name']=='支持', #背景音乐
        icon_shape:  WebsiteTemplate::ICON_SHAPES.key(li['icon_shape_name']),             #图标形状
        scroll_way:  WebsiteTemplate::SCROLL_WAYS.key(li['scroll_way_name']),             #滚动方式
      }

      image = li.css('img').first
      #/uploads/website_template/pic/thumb_fb2211bfc85256e2b1ae54e9904020fe.png
      #http://winwemedia.com/uploads/website_template/pic/337f428603f67c4fa8855d38b7abac0e.png
      src = image['src']
      basename = File.basename( src )
      original_basename = basename.split('_').last
      attrs[:pic_key] = original_basename
      puts "attrs=#{attrs}"
      create_website_template( attrs )
      span = li.css('div.text+span').first
      puts span.content
    end
  }
end



# src: /uploads/website_template/pic/thumb_fb2211bfc85256e2b1ae54e9904020fe.png
# uri: http://winwemedia.com/uploads/website_template/pic/337f428603f67c4fa8855d38b7abac0e.png
def download_template_images( src )
  dir = File.dirname( src )
  basename = File.basename( src )
  original_basename = basename.split('_').last
  uri = "http://winwemedia.com#{dir}/#{original_basename}"
  puts uri
  file = open( uri )
  new_path = File.expand_path( "pic/#{original_basename}", File.dirname(__FILE__))
  puts "uri=#{uri}, path=#{file.path} - new_path=#{new_path}"

  FileUtils.mv(file.path, new_path)
  #save path db/templates/images
end

def create_website_template(attrs)
  template = WebsiteTemplate.find_or_create_by!( attrs )
  if template.website_tag_id == 12
    template.update_attribute :series, 1
  end
end

parse_template_html
