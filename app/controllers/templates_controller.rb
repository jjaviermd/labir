class TemplatesController < ApplicationController
  def index
    if laboratory_signed_in?
      @templates = current_laboratory.templates.all
      @macro_templates = current_laboratory.macro_templates.all
      @micro_templates = current_laboratory.micro_templates.all
      @diagnosis_templates = current_laboratory.diagnosis_templates.all
    elsif pathologist_signed_in?
      @templates = current_pathologist.laboratory.templates.all
      @macro_templates = current_pathologist.laboratory.macro_templates.all
      @micro_templates = current_pathologist.laboratory.micro_templates.all
      @diagnosis_templates = current_pathologist.laboratory.diagnosis_templates.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @templates }
    end
  end

  def show
    @template = current_laboratory.macro_templates.find params[:id]
    respond_to do |format|
      format.html # index.html.erb
      # format.xml { render xml: @template }
      format.json { render json: @template }
    end
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
    if @template.destroy
      respond_to do |format|
        format.html { redirect_to templates_path, success: "#{@template.name} template deleted" }
        format.turbo_stream { flash.now[:success] = "#{@template.name} template deleted" }
      end
    else
      flash.now[:danger] = "#{@template.name} template not deleted"
    end
  end

  private

  def template_params
    params.require(:template).permit(:prefix, :name, :text)
  end
end
