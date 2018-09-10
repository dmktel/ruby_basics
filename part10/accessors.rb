module Acсessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        @history = instance_variable_get(var_history) || []
        last_value = instance_variable_get(var_name)
        instance_variable_set(var_history, @history << last_value )
      end
      define_method("#{name}_history") {instance_variable_get(var_history)}
    end
  end

  def strong_attr_accessor(name, var_class)
    var_name = "@#{name}".to_sym
    define_method(name) {instance_variable_get(var_name)}
    define_method("@#{name}=".to_sym) do |value|
      raise 'Error! Wrong attribute type!' unless value.istance_of?(var_class)
      instance_variable_set(var_name, value)
    end
  end
end
