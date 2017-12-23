module ControllerHelpers
  module StrongParameters
    def permitted_attributes
      PermittedAttributes
    end

    delegate *PermittedAttributes::ATTRIBUTES,
             to: :permitted_attributes,
             prefix: :permitted
  end
end
