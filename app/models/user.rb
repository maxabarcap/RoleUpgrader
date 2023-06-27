class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  validates :name, presence: true
  enum role: [:normal, :administrator]
  
  def upload_photo(file)
    obj = S3_BUCKET.object("uploads/#{id}/#{file.original_filename}")
    obj.upload_file(file.path, acl: 'public-read')
    update(photo_url: obj.public_url)
  end

  def administrator?
    role == 1
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end
