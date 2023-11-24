class TemplatesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @template = current_laboratory.templates.build
  end

  def create
    @template = current_laboratory.templates.build template_params
    if @template.save
      flash[:success] = "#{@template.name} template  created."
    else
      flash.now[:danger] = "#{@template.name} template not created."
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def template_params
    params.require(:template).permit(:type, :prefix, :name, :text)
  end
end
