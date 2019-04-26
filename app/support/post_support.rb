class PostSupport
  def post_types
    @post_types = PostType.pluck(:name, :id)
  end
  def posts current_user
    @posts = Post.posts(current_user)
  end
  def search_posts search_posts
    @search_posts = Post.search_post(search_posts) if search_posts
  end
  def searchs search
    @searchs = User.search(search) if search
  end
  def posts_types post_type_id
    @posts_types = Post.search_type(post_type_id) if post_type_id
  end
end
