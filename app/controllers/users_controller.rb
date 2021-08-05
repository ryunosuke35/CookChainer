class UsersController < ApplicationController
  def level_up
    user = current_user

    totalExp = user.experience_point
    totalExp += 5

    user.experience_point = totalExp
    user.update(experience_point: totalExp)

    levelSetting = LevelSetting.find_by(level: user.level + 1);


    if levelSetting.thresold <= user.experience_point
      user.level = user.level + 1
      user.update(level: user.level)
    end

    redirect_to controller: :posts, action: :index

  end
end
