class SearchLogController < ApplicationController

  def index
    # Example: Fetch search terms from SearchLog model
    @popular_searches = SearchLog.group(:term).order('count_id DESC').limit(10).count(:id).keys
    @recent_searches = SearchLog.order(created_at: :desc).limit(10).pluck(:term)

    # Filter dictionary words
    @popular_searches = filter_dictionary_words(@popular_searches)
    @recent_searches = filter_dictionary_words(@recent_searches)
  end

  private

  # Check dictionary words from system dictionary or predefined list
  def filter_dictionary_words(words)
    dictionary = File.readlines('/usr/share/dict/words').map(&:strip).map(&:downcase)
    words.select { |word| dictionary.include?(word.downcase) }
  end
end