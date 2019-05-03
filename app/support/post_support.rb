class PostSupport
  def post_types
    @post_types = PostType.pluck(:name, :id)
  end
  def searchs search
    @searchs = User.search(search) if search
  end
  def posts_types post_type_id
    @posts_types = Post.search_type(post_type_id) if post_type_id
  end
end
