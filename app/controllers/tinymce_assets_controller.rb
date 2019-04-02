class TinymceAssetsController < ApplicationController
  def create
    render json: {
      image: {
        url: view_context.image_url(image)
      }
    }, content_type: "text/html"
  end
end
