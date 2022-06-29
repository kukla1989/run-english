class Article < ApplicationRecord
	has_many :sentences, dependent: :destroy
end
