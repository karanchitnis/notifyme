class LinksController < ApplicationController
	def embed
    embedly_api = Embedly::API.new :key => '1e88dffcdc9d40809a8dba052025f927', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; karanchitnis92@gmail.com)'
    obj = embedly_api.oembed :url => params[:text]
    if obj[0].error_code != 400
      @embed_title = obj[0].title
      @embed_desc = obj[0].description
      @embed_norm_url = params[:text]
      @embed_thumbnail = obj[0].thumbnail_url
      #@embed_width = 560
      #@embed_height = (560/(obj[0].width)) * obj[0].height
      @embed_type = obj[0].type
      if @embed_type == "video"
        @embed_format = obj[0].html[1..6]
        linkhref = obj[0].html.split("src=")[1]
        @embed_link = linkhref[1..linkhref.length].split(' ')[0].split('<')[0]
      end
      if @embed_link == nil 
        @embed_link = obj[0].url
      end
      @contentdiv = "content" + params[:contentid]
    end
  	respond_to do |format|
      #format.html { redirect_to root_url }
      format.js
    end
	end
end