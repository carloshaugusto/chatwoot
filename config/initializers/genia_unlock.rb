# GENIA OS - AGGRESSIVE UNLOCKER (RESCUE)
Rails.configuration.to_prepare do
  if defined?(InstallationConfig)
    InstallationConfig.class_eval do
      def locked?; false; end
      def visible?; true; end
      def self.find_by(name:)
        require 'ostruct'
        case name
        when 'CHATWOOT_EDITION' then OpenStruct.new(value: 'enterprise', locked?: false)
        when 'CUSTOM_BRANDING' then OpenStruct.new(value: true, locked?: false)
        when 'INSTALLATION_IDENTIFIER' then OpenStruct.new(value: 'genia-os-v3', locked?: false)
        else begin; super; rescue; nil; end
        end
      end
    end
  end
end