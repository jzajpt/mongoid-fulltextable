# encoding: utf-8

require 'active_support/concern'
require 'core_ext/string'

module Mongoid

  module Fulltextable

    extend ActiveSupport::Concern

    included do

      field :_keywords, :type => Array, :accessible => false

      index :_keywords

      scope :fulltext, lambda { |str| where(:_keywords => /#{str}/i) }

    end

    module ClassMethods

      # Define fields which will be saved into full-text index.
      def fulltextable_fields(*args)
        before_save :update_keywords

        self.instance_variable_set(:@index_fields, args)
      end

      # Define proc which populates data for full-text index.
      def fulltextable(&block)
        before_save :update_keywords

        self.instance_variable_set(:@index_proc, block)
      end

    end

    module InstanceMethods

      protected

      def update_keywords
        update_keywords_from_proc if index_proc
        update_keywords_from_fields if index_fields && !index_fields.empty?
      end

      def update_keywords_from_proc
        self._keywords = []
        instance_eval &index_proc
      end

      def update_keywords_from_fields
        keywords = index_fields.map do |field|
          value      = self.send(field).to_s
          simplified = value.without_accents if value.respond_to?(:without_accents)

          simplified == value ? value : [value, simplified]
        end.reject(&:blank?).compact.flatten.uniq

        self._keywords = keywords
      end

      def index_proc
        @index_proc ||= self.class.instance_variable_get(:@index_proc)
      end

      def index_fields
        @index_fields ||= self.class.instance_variable_get(:@index_fields)
      end

      def indexes(*args)
        keywords = args.reject(&:blank?).compact.uniq.map do |value|
          value      = value.to_s
          simplified = value.without_accents if value.respond_to?(:without_accents)
          simplified == value ? value : [value, simplified]
        end
        self._keywords += keywords.flatten.compact
      end

    end

  end

end