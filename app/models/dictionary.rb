class Dictionary < ActiveRecord::Base
  attr_accessible :name

  def self.check_profanity_words(params)
    profane_words = []
    params[:body].split(',').each do |word|
      entry = Dictionary.where(:name => word).first
      profane_words.push(entry.name) if entry.present?
    end
    if profane_words.count != 0
      {:message => 'Profane words found: ' + profane_words.join(','), :status => false}
    else
      {:message => 'No profane word found', :status => true}
    end
  end
end
