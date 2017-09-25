class Song < ActiveRecord::Base

  validates :title, presence: true
  validate :release_year_valid
  validates :title, uniqueness: true

  def release_year_valid

    if self.released
      if !self.release_year
        self.errors[:release_year] << "Release year is not present"
      elsif self.release_year < Time.now.year
        return true
      elsif self.release_year > Time.now.year
        self.errors[:release_year] << "Release year is in the future"
      end
    else
      if !self.release_year
        return true
      else
        self.errors[:release_year] << "Can't have a release year if song has not been released yet"
      end
    end
  end

end
