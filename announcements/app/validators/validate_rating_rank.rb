class ValidateRatingRank < ActiveModel::Validator
  def validate(record)
    unless record.rank > 0
      record.errors[:rank] << (options[:message] || 'Choose a rate before submit!')
    end
  end
end