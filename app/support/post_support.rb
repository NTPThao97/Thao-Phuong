class PostSupport
  def post_types
    @post_types = PostType.pluck(:name, :id)
  end
end
