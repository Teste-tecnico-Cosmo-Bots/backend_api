# app/policies/user_policy.rb

class UserPolicy < ApplicationPolicy
  def index?
    true # Todos os usuários podem acessar a lista de usuários
  end

  def show?
    @user == current_user || @user.admin? # Apenas o próprio usuário ou um administrador pode ver o perfil
  end

  def update?
    @user == current_user # Apenas o próprio usuário pode atualizar o perfil
  end

  def destroy?
    @user == current_user # Apenas o próprio usuário pode excluir o perfil
  end
end
