FactoryBot.define do
  factory :level_setting do
    level { 1 }
    thresold { 0 }
  end
  factory :second_level_setting, class: LevelSetting do
    level { 2 }
    thresold { 15 }
  end
end
