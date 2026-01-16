# config/initializers/force_custom.rb
# --- GENIA OS UNLOCKER ---

# 1. Forçar Variáveis de Ambiente
ENV['CW_EDITION'] = 'enterprise'
ENV['CHATWOOT_EDITION'] = 'enterprise'
ENV['BILLING_ENABLED'] = 'false'

# 2. Ignorar módulos de verificação de licença
class Module
  def prepend_mod_with(name); true; end
  def include_mod_with(name); true; end
end

# 3. Reescrever as regras do sistema
Rails.configuration.to_prepare do
  
  # A. Burlar a comunicação com o servidor de licenças oficial
  class ::ChatwootHub
    def self.installation_identifier; '00000000-0000-0000-0000-000000000000'; end
    def self.support_config; { support_identifier_hash: 'genia_mock_hash' }; end
    def self.sync_with_hub; true; end
    def self.latest_version; '9.9.9'; end # Evita avisos de update
  end

  # B. Forçar a edição Enterprise no Banco de Dados Virtual
  InstallationConfig.class_eval do
    def self.find_by(name:)
      return new(name: name, value: 'enterprise') if name == 'CHATWOOT_EDITION'
      super
    end
  end

  # C. Liberar TODAS as funcionalidades para todas as contas
  Account.class_eval do
    def feature_enabled?(_feature); true; end
    def plan_name; 'enterprise'; end
    def subscribed_features
      # Lista completa de funcionalidades Enterprise
      [
        'audit_logs', 'campaigns', 'reports', 'automation', 'sla', 
        'advanced_search', 'team_management', 'agent_management', 
        'help_center', 'inbox_views', 'custom_branding'
      ]
    end
  end

  # D. Garantir Super Admin (Caso precise recuperar acesso)
  User.class_eval do
    def super_admin?
      return true if email == 'carloshaugusto84@gmail.com' || email == 'admin@chatwoot.com'
      super
    end
  end
end
