# encoding: utf-8

require 'unicode_utils'

class String

  def without_accents
    UnicodeUtils.nfkd(self).gsub(/[^\x00-\x7F]/, '').to_s
  end

end
