# encoding: utf-8

class UserUploader < ImageUploader

  version :thumb_avatar

  version :thumb_avatar do
    process resize_to_fill: [120,120]
    process convert: :png
  end

end
