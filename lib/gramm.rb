require "gramm/acts_as_grammer"
require "gramm/model"

module Gramm

    # Get the list of purgable Gramms
    def self.purge_list
      Gramm.where(sender_deleted: true, recipient_deleted: true)
    end

end # module Gramm


