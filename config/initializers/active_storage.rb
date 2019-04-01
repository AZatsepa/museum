# frozen_string_literal: true

module ActiveStorage
  class Attached
    class Many < Attached
      def attach(*attachables)
        attachables.flatten.collect do |attachable|
          if record.new_record?
            attachments.build(record: record, blob: create_blob_from(attachable))
          elsif !record.is_a? ActionText::RichText
            attachments.create!(record: record, blob: create_blob_from(attachable))
          end
        end
      end
    end
  end
end
