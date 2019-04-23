class Admin::PostTypesController < Admin::BaseController
  def index
    @post_types = PostType.all
    @post_type = PostType.new
  end

  def create
    post_type = PostType.new post_type_params
    if post_type.save
      flash[:success] = "Success"
      redirect_to admin_post_types_path
    else
      flash[:warning] = "Fails"
      redirect_to admin_post_types_path
    end
  end

  def edit;  end

  def update
    @post_type = PostType.find_by(id: params[:id])
    if @post_type.update post_type_params
      flash[:success] = "Success"
      redirect_to admin_post_types_path
    else
      flash[:warning] = "Fails"
      redirect_to admin_post_types_path
    end
  end

  def destroy
    @post_type = PostType.find_by(id: params[:id])
    @post_type.delete
    redirect_to admin_post_types_path
  end

  private
  def post_type_params
    params.require(:post_type).permit :name
  end
end
