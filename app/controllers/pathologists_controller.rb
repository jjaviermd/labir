# frozen_string_literal: true

class PathologistsController < ApplicationController
  before_action :set_pathologist, only: %i[edit update destroy pending finished]

  def index
    if laboratory_signed_in?
      @pathologists = current_laboratory.pathologists.all
    elsif pathologist_signed_in?
      @pathologists = current_pathologist.laboratory.pathologists.all
    end
  end

  def show
    if laboratory_signed_in?
      @pathologist = current_laboratory.pathologists.includes(cases: :patient).find(params[:id])
    elsif pathologist_signed_in?
      @pathologist = current_pathologist.laboratory.pathologists.includes(cases: :patient).find(params[:id])

    end
    @pending_cases = @pathologist.cases.not_diagnosed
    @finished_cases = @pathologist.cases.diagnosed
  end

  def new
    unless laboratory_signed_in?
      redirect_to pathologists_path
      flash[:danger] = "You need to log in as a Laboratory to create a new Pathologist"
    end
    @pathologist = Pathologist.new
  end

  def create
    if laboratory_signed_in?
      @pathologist = current_laboratory.pathologists.build(pathologist_params)
    elsif pathologist_signed_in?
      @pathologist = current_pathologist.laboratory.pathologists.build(pathologist_params)
    end
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
    if pathologist_signed_in? && @pathologist.id != current_pathologist.id
      redirect_to pathologists_path
      flash[:danger] = "You can only edit your own profile"
    end
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
    params.require(:pathologist).permit(:email, :password, :last_name, :name, :registry_number, :sign)
  end

  def set_pathologist
    if laboratory_signed_in?
      @pathologist = current_laboratory.pathologists.find params[:id]
    elsif pathologist_signed_in?
      @pathologist = current_pathologist.laboratory.pathologists.find params[:id]

    end
  end
end
