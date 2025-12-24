class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class


  def self.human_enum(enum_name, enum_value)
    i18n_key = "activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}"
    I18n.t(i18n_key, default: enum_value.to_s.humanize)
  end

  def self.enum_options(enum_name)
    stuff = public_send(enum_name.to_s.pluralize).keys.map do |k|
      [human_enum(enum_name, k), k]
    end

    Rails.logger.debug { "Enum options for #{enum_name}: #{stuff.inspect}" }

    stuff
  end
end
