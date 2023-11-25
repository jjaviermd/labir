class MicroTemplatesController < ApplicationController
  def new
    @template = current_laboratory.micro_templates.build
  end

  def create
    @template = current_laboratory.micro_templates.build template_params

    if @template.save
      redirect_to templates_path
      flash[:success] = "#{@template.name} template  created."
    else
      flash.now[:danger] = "#{@template.name} template not created."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @template = current_laboratory.templates.find params[:id]
  end

  def update
    @template = current_laboratory.micro_templates.find params[:id]
    if @template.update template_params
      redirect_to templates_path
      flash[:success] = "#{@template.name} template updated"
    else
      flash.now[:danger] = "#{@template.name} template not updated"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def template_params
    params.require(:micro_template).permit(:prefix, :name, :text)
  end
end
