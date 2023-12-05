class MicroTemplatesController < ApplicationController
  def index
    @templates = current_laboratory.micro_templates.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @templates }
    end
  end

  def create
    @template = current_laboratory.micro_templates.build template_params
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
    @template = current_laboratory.micro_templates.find params[:id]
    if @template.update template_params
      redirect_to templates_path
      flash[:success] = "#{@template.name} template updated"
    else
      flash.now[:danger] = "#{@template.name} template not updated"
      render "templates/edit", status: :unprocessable_entity
    end
  end

  private

  def template_params
    params.require(:micro_template).permit(:prefix, :name, :text)
  end
end
