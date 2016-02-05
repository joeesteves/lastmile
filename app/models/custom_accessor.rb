module CustomAccessor
  extend ActiveSupport::Concern
  module ClassMethods
    # custom_accessor to_i: [:metodo1, :metodo2], to_s: [:nombre, :apellido]
    def custom_accessor attrs = {}
      attrs.each do |cast,met_ary|
        met_ary.each do |metodo|
          define_method(metodo) { instance_variable_get("@#{metodo}") }
          define_method("#{metodo}=") { |val| instance_variable_set("@#{metodo}", val.send(cast)) }
        end
      end
    end
  end
end
