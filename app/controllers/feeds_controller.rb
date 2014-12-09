class FeedsController < ApplicationController
  def index
    feedable = Rssify::Feedable.parse_link(params[:url])

    if feedable.valid?
      @feed = feedable.feed

      render atom: @feed
    else
      redirect_to root_path, alert: "#{feedable.class}: link is not valid"
    end
  rescue ArgumentError
    redirect_to root_path, alert: 'Link is not supported yet'
  end
end
