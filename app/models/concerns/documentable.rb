# frozen_string_literal: true

# Module related with the creation of pdf tables
module Documentable
  extend ActiveSupport::Concern

  included do
    def pdf_table(document = pdf)
      document.table(table_data, position: :center, width: 550, cell_style: { borders: %i[] }) do
        row(0).borders = [:top]
        row(-1).borders = [:bottom]
        column(0).font_style = :bold
        column(2).font_style = :bold
      end
    end
  end

  class_methods do
  end
end
