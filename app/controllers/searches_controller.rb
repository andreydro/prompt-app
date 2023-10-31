# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
    records = Phrase.fulltext_search(search_params[:query]).records
    if records.present?
      render json: records.map { |record| { id: record.id, value: record.value } }
    else
      render json: { error: 'No results found' }
    end
  end

  private

  def search_params
    params.permit(:query)
  end
end
