class JoinsController < ApplicationController
  before_action :authenticate_user!

  def create
    group = Group.find(join_params[:group_id])
    user = User.find_by(email: join_params[:user_email])
    if user
      @info = group.invite_member(user, group)
      redirect_to group_path(group), notice: @info.to_s
    elsif join_params[:user_email].empty?
      redirect_to group_path(group), alert: "招待する人のメールアドレスを入力してください"
    else
      redirect_to group_path(group), alert: "#{join_params[:user_email]}のアドレスは未登録のようです。確認してください"
    end
  end

  def destroy
    @join = Join.find(params[:id])
    group = @join.group
    if @join.destroy
      redirect_to events_path, notice: "グループから脱退しました！"
    else
      redirect_to group_path(group), notice: "グループ脱退に失敗しました"
    end
  end

  private

  def join_params
    params.permit(:group_id, :user_email)
  end

  def join_delete_params
    params.permit(:group_id, :user_id)
  end
end
