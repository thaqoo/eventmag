# frozen_string_literal: true

module RuboCop
  module AST
    # A node extension for `resbody` nodes. This will be used in place of a
    # plain node when the builder constructs the AST, making its methods
    # available to all `resbody` nodes within RuboCop.
    class ResbodyNode < Node
      # Returns the body of the `rescue` clause.
      #
      # @return [Node, nil] The body of the `resbody`.
      def body
        node_parts[2]
      end

      # Returns the exception variable of the `rescue` clause.
      #
      # @return [Node, nil] The exception variable of the `resbody`.
      def exception_variable
        variable = node_parts[1]
        return variable if variable

        # When resbody is an implicit rescue (i.e. `rescue e` style),
        # the exception variable is descendants[1].
        descendants[1]
      end
    end
  end
end
