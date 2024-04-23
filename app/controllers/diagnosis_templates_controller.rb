class DiagnosisTemplatesController < ApplicationController
  def index
    if laboratory_signed_in?
      @templates = current_laboratory.diagnosis_templates.all
    elsif pathologist_signed_in?
      @templates = current_pathologist.laboratory.diagnosis_templates.all

    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @templates }
    end
  end

  def create
    if laboratory_signed_in?
      @template = current_laboratory.diagnosis_templates.build template_params
    elsif pathologist_signed_in?
      @template = current_pathologist.laboratory.diagnosis_templates.build template_params
    end
    if @template.save
      respond_to do |format|
        format.html { redirect_to templates_path, success: "#{@template.name} template  created." }
        format.turbo_stream { flash.now[:success] = "#{@template.name} template  created." }
      end
    else
      flash.now[:danger] = "#{@template.name} template not created."
      render "templates/new", status: :unprocessable_entity
    end
  end

  def update
    if laboratory_signed_in?
      @template = current_laboratory.diagnosis_templates.find params[:id]
    elsif pathologist_signed_in?
      @template = current_pathologist.laboratory.diagnosis_templates.find params[:id]
    end
    if @template.update template_params
      respond_to do |format|
        format.html { redirect_to templates_path, success: "#{@template.name} template updated" }
        format.turbo_stream { flash.now[:success] = "#{@template.name} template updated" }
      end
    else
      flash.now[:danger] = "#{@template.name} template not updated"
      render "templates/edit", status: :unprocessable_entity
    end
  end

  private

  def template_params
    params.require(:diagnosis_template).permit(:prefix, :name, :text)
  end
end
