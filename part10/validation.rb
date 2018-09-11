module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, val_type, param = nil)
      self.validations ||= []
      self.validations << { attr: name, val_type: val_type, param: param }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |item|
        value = instance_variable_get("@#{item[:attr]}")
        name_val = ('val_' + item[:val_type].to_s).to_sym
        send(name_val, value, item[:param])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def val_presence(value, _param)
      raise 'Input can not be blank!' if value.nil? || value.empty?
    end

    def val_format(value, format_val)
      raise 'Bad format input!' if value.to_s !~ format_val
    end

    def val_type(value, type_val)
      raise 'Another class!' unless value.instance_of?(type_val)
    end

    def val_kind(value, kind_val)
      all_checking = value.all? { |item| item.instance_of?(kind_val)}
      raise "Inputs are different class!" unless all_checking
    end
  end
end
