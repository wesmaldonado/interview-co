module Reporter
  class Application
    def initialize(argv)
      @options = parse_opt(argv)
    end
    def run
    end
    def parse_opt(argv)
     # Default requirements
     # --level-uid
     # --level-api-token
     # --credentials
      # Similar to AWS generate credentials but not interactive.
      # Depends on --level-email and --level-password
      # --level-email
      # --level-password
      return "TODO"
    end
  end
end
