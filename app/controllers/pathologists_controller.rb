# frozen_string_literal: true

class PathologistsController < ApplicationController
  before_action :set_pathologist, only: %i[edit update destroy pending finished]
  def index
    @pathologists = current_laboratory.pathologists.all
  end

  def show
    @pathologist = current_laboratory.pathologists.includes(cases: :patient).find(params[:id])
    @pending_cases = @pathologist.cases.not_diagnosed
    @finished_cases = @pathologist.cases.diagnosed
  end

  def new
    @pathologist = Pathologist.new
  end

  def create
    @pathologist = current_laboratory.pathologists.build(pathologist_params)
    if @pathologist.save
      respond_to do |format|
        format.html { redirect_to pathologist_path(@pathologist), success: "#{@pathologist.full_name} profile created" }
        format.turbo_stream { flash.now[:success] = "#{@pathologist.full_name} profile created" }
      end
    else
      render :new, status: :unprocessable_entity
      flash.now[:danger] = "Something went wrong. #{@pathologist.full_name} profile could not created"
    end
  end

  def edit
  end

  def update
    if @pathologist.update(pathologist_params)
      redirect_to pathologist_path(@pathologist)
      flash[:success] =
        "#{@pathologist.full_name} profile haave been updated"
    else
      flash.now[:danger] =
        "Something went wrong. #{@pathologist.full_name} profile  notupdated"
    end
  end

  def pending
    @pending_cases = @pathologist.cases.includes(:patient).not_diagnosed
  end

  def finished
    @finished_cases = @pathologist.cases.includes(:patient).diagnosed
  end

  def destroy
  end

  private

  def pathologist_params
    params.require(:pathologist).permit(:last_name, :name, :registry_number, :sign)
  end

  def set_pathologist
    @pathologist = current_laboratory.pathologists.find params[:id]
  end
end
