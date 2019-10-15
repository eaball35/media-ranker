class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def create
    work_id = params["work_id"]
    user_id = session[:user_id]
    @vote = Vote.new(work_id: work_id, user_id: user_id)
    work = Work.find_by(id: work_id)
    work.vote_count += 1
    # raise
    
    if @vote.save && work.save
      flash[:success] = "Successfully voted for #{work.title}"
      redirect_to votes_path
    else
      flash[:error] = "Did NOT vote successfully"
      redirect_back(fallback_location: root_path)
      return
    end
  end
  
  def destroy
    vote = Vote.find_by(id: params[:id])
    if vote.nil?
      head :not_found
      return
    elsif vote.destroy
      flash[:success] = "Successfully deleted vote for #{vote.work.title}"
      redirect_to votes_path
      return
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def vote_params
    return params.require(:vote).permit(:work_id, :user_id)
  end

end