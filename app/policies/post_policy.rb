class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all # Retorna todos os posts para todos os usuários
    end
  end

  def show?
    true # Qualquer usuário pode ver um post
  end

  def create?
    user.present? # Apenas usuários logados podem criar posts
  end

  def update?
    user.present? && user == post.user # Apenas o autor do post pode atualizá-lo
  end

  def destroy?
    user.present? && user == post.user # Apenas o autor do post pode excluí-lo
  end
end
