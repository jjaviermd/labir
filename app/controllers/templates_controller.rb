class TemplatesController < ApplicationController
  def index
    @templates = current_laboratory.templates.all
  end

  def show
  end

  def new
    @template = case params[:template_type]
    when "macro_template"
      current_laboratory.macro_templates.build
    when "micro_template"
      current_laboratory.micro_templates.build
    when "diagnosis_template"
      current_laboratory.diagnosis_templates.build
    end
  end

  def edit
    @template = current_laboratory.templates.find params[:id]
  end

  def destroy
    @template = current_laboratory.templates.find params[:id]
    if @template.delete
      redirect_to templates_path
      flash[:success] = "#{@template.name} template deleted"
    else
      flash.now[:danger] = "#{@template.name} template not deleted"
    end
  end

  private

  def template_params
    params.require(:template).permit(:prefix, :name, :text)
  end
end
