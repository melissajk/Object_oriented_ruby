class SecretFile
                          # remove attr_reader
  def initialize(secret_data, security)
    @data = secret_data
    @security = security  # not SecurityLogger.new?
  end
  
  def data
    @security.create_log_entry
    @data
  end
end

# Modify this so that any attempts to access #data results in a log entry being
# generated. Any call to the class that allows data to be returned must first 
# call a logging class

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end

# Hint assume you can modify the initialize method in the SecretFile to have an
# instance of SecurityLogger be passed in as an additional argument (collaborator)
