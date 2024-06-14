class User < ApplicationRecord
  # Relacionamentos
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  self.primary_key = :uuid
  
  before_create :generate_uuid
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nome, presence: true
  
  private
  
  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
