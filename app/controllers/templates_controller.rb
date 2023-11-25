class TemplatesController < ApplicationController
  def index
    @templates = current_laboratory.templates.all
  end

  def show
  end

  def destroy
  end

  private

  def template_params
    params.require(:template).permit(:prefix, :name, :text)
  end
end
