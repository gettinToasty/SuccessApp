class GoalsController < ApplicationController

  before_action :same_author, only: [:update, :edit, :destroy]
  before_action :see_private, only: [:show]

  def index
    @goals = Goal.where(private: "PUBLIC").to_a
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new

  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    user = @goal.user
    @goal.destroy
    redirect_to user_url(user)
  end

  def mark_as_complete
    @goal = Goal.find(params[:id])
    @goal.status = "COMPLETE"
    @goal.updated_at = Time.now
    @goal.save
    redirect_to user_url(@goal.user)
  end

  private

  def see_private
    @goal = Goal.find(params[:id])
    redirect_to goals_url unless @goal.private == "PUBLIC" || current_user == @goal.user
  end

  def goal_params
    params.require(:goal).permit(:description, :status, :private)
  end

  def same_author
    @goal = Goal.find(params[:id])
    redirect_to goals_url unless current_user.id == @goal.user_id
  end
end
