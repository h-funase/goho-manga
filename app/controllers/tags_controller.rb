class TagsController < ApplicationController

  def index
    if params[:tag_name]
      @tasks = @tasks.tagged_with("#{params[:tag_name]}")
    end

  end
  
  def new
    @tag = Tag.new
  end

  def create
    @group = Group.new(group_params)
    if @tag.save
      redirect_to root_path, notice: 'タグを追加しました'
    else
      render :new
    end
  end

  def edit
  end

  def updata
  end

  private
  

  def task_params
    params.require(:user).permit(:name, :description, :tag_list) 
  end

end
