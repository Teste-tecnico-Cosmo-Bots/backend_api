class User < ApplicationRecord
  # Relacionamentos
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # Garanta que um UUID seja 
  before_create :generate_uuid
  
  # Configurações do Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Validações
  validates :nome, presence: true
  
  private
  
  # Gera um UUID antes de criar o usuário, se não estiver definido
  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
