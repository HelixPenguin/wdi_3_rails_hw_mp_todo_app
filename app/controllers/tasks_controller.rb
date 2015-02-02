class TasksController < ApplicationController
  before_action :set_list, except: :catalog
  before_action :set_task, only: [:flop, :edit, :update, :destroy]

  def flop
    @task.completed = !@task.completed
    @task.save

    redirect_to :back
end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    task_params[:completed] = true
    @task = @list.tasks.build(task_params)
    if @task.save
      redirect_to list_path(@list), notice: 'Task was successfully created.'
    else
      redirect_to list_path(@list), notice: 'Task cannot be blank.'
    end
  end

  def update
    if @task.update(task_params)
      redirect_to list_path(@list), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to list_path(@list), notice: 'Task was successfully destroyed.'
  end

  def catalog
    @tasks = Task.all
  end

  private

    def set_list
      @list = List.find(params[:list_id])
    end

    def set_task
      @task = @list.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name)
    end
end
