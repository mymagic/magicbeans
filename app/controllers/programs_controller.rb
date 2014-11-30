class ProgramsController < ApplicationController
  before_action :set_program, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @programs = Program.all
    respond_with(@programs)
  end

  def show
    @program = Program.find(params[:id])
  end

  def new
    @program = Program.new
    1.times {@program.activities.build}
    respond_with(@program)
  end

  def edit
  end

  def create
    @program = Program.new(program_params)
    if @program.save
        redirect_to programs_path, success: 'Successfully created a program!'
    else
        render action: "new"
    end
  end

  def update
    if @program.update(program_params)
      redirect_to programs_path, success: 'Program was successfully updated!'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @program.destroy
      redirect_to programs_path, success: 'Program was successfully deleted!'
    else
      render action: 'index'
    end
  end

  private
    def set_program
      @program = Program.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      redirect_to(root_url, alert: 'Program not found')
    end

    def program_params
      params.require(:program).permit(:name, :description, :speaker, :speakerbio, :biourl, :keytakeways, :tags, :resources, activities_attributes: [:id, :name, :venue, :description, :speaker, :speakerbio, :biolink, :keytakeaway, :prerequisite, :maxattendee, :tags, :resources, :_destroy])
    end
end
