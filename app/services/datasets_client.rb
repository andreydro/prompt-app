require 'net/http'
require 'net/https'
require 'uri'

class DatasetsClient
  SERVER_URL = 'https://datasets-server.huggingface.co/rows'.freeze
  MIN_LENGTH = 1
  MIN_OFFSET = 0

  def initialize(length = MIN_LENGTH, offset = MIN_OFFSET)
    @length = length
    @offset = offset
  end

  def request
    uri = URI(SERVER_URL)
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  rescue error
    Rails.logger.error(error)
  end

  private

  def params
    {
      dataset: 'Gustavosta/Stable-Diffusion-Prompts',
      config: 'default',
      split: 'train',
      offset: @offset,
      length: @length
    }
  end
end
