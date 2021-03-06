class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :correct_user, only: [:destroy, :show, :update, :edit]
    
    
    def index
        @tasks = current_user.tasks.all.page(params[:page])
        @user = current_user
    end

    def show
    end

    def new
        @task = Task.new
    end

    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = "Taskが正常に追加されました"
            redirect_to @task
        else
            # @tasks = current_user.task.order('created_at DESC').page(params[:page])
            flash.now[:danger] = "Taskが追加されませんでした"
            render :new
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
            flash[:success] = 'Taskは正常に更新されました'
            redirect_to @task
        else
            flash[:danger] = 'Taskは更新されませんでした'
            render :edit
        end
    end

    def destroy
        @task.destroy
        flash[:success] = 'Taskは削除されました'
        redirect_to root_url
    end
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    private
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    
end
