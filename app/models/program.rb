class Program < ActiveRecord::Base
    # Activity Association
    has_many :activities, dependent: :destroy
    mount_uploader :speaker_img, ImageUploader
    mount_uploader :program_img, ImageUploader
    accepts_nested_attributes_for :activities, allow_destroy: true
    # , reject_if: lambda {|attributes| attributes['name'].blank?}
end
