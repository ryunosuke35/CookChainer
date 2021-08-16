FactoryBot.define do
  factory :level_setting do
    level { 1 }
    thresold { 0 }
  end
  factory :second_level_setting, class: LevelSetting do
    level { 2 }
    thresold { 15 }
  end
  factory :third_level_setting, class: LevelSetting do
    level { 3 }
    thresold { 30 }
  end
end
