# frozen_string_literal: true

module PackagesHelper
  def authors(hash)
    str = ''
    hash.each do |k, v|
      str = if v.nil?
              "#{k}(-). "
            else
              "#{k}(#{v}). "
            end
    end
    str
  end

  def maintainers(hash)
    "#{hash['name']}(#{hash['email']})"
  end
end
