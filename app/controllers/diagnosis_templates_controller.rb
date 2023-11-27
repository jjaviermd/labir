class DiagnosisTemplatesController < ApplicationController
  def create
    @template = current_laboratory.diagnosis_templates.build template_params

    if @template.save
      redirect_to templates_path
      flash[:success] = "#{@template.name} template  created."
    else
      flash.now[:danger] = "#{@template.name} template not created."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @template = current_laboratory.diagnosis_templates.find params[:id]
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
    params.require(:diagnosis_template).permit(:prefix, :name, :text)
  end
end
