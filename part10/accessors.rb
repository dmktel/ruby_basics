module Acсessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) {instance_variable_get(var_name)}
      define_method("#{name}".to_sym) do |value|
        instance_variable_set(var_name, value)
        @history ||= {}
        @history[name] ||= []
        @history[name].push(value)
      end
    end
    define_method("#{name}=_history") { @history ? @history[name] : [] }
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
