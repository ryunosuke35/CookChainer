class UsersController < ApplicationController
  def level_up
    user = current_user

    totalExp = user.exp_point
    totalExp += 5

    user.exp_point = totalExp
    user.update(exp_point: totalExp)

    levelSetting = LevelSetting.find_by(level: user.level + 1);


    if levelSetting.thresold <= user.exp_point
      user.level = user.level + 1
      user.update(level: user.level)
    end

    redirect_to controller: :posts, action: :index

  end
end
