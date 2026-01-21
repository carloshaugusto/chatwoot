class ChatwootHub
  class << self
    def installation_identifier; 'genia-os-rescue'; end
    def sync_with_hub; true; end
    def register_instance(company_name, owner_email); true; end
    def instance_config
      { 'h_r' => false, 'a_l' => 999999, 'i_l' => 999999 }
    end
    def is_enterprise?; true; end
    def pricing_plan; 'enterprise'; end
    def support_config; { support_identifier_hash: 'genia-secure-hash' }; end
  end
end