module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :check

    def validate(*args)
      args ||= []
      self.check ||= []
      self.check.push(args)
    end
  end

  module InstanceMethods
    def validate!
      self.class.check.each { |arg| self.send arg[1].to_sym,\
         instance_variable_get("@#{arg[0]}".to_sym), arg[2] }
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def presence(value, var)
      raise 'Input can not be blank!' if value.nil? || value.empty?
    end

    def format(value, var)
      raise 'Bad format input!' if value !~ var
    end

    def kind(value, var)
      raise 'Another class!' if value.first.instance_of?(var) ||\
      value.last.instance_of?(var)
    end

    def same(value, var)
      raise 'Can not add same stations twice' if value.first == value.last
    end
  end
end
