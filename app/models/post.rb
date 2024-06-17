class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  def formatted_created_at
    time_ago_in_words(self.created_at)
  end

  def formatted_created_at_long
    format_date(self.created_at)
  end

  def time_ago_in_words(time)
    diff_seconds = Time.current.to_i - time.to_i
    case diff_seconds
    when 0..59
      "#{diff_seconds} segundos atrás"
    when 60..3599
      "#{diff_seconds / 60} minutos atrás"
    when 3600..86399
      "#{diff_seconds / 3600} horas atrás"
    when 86400..604799
      "#{diff_seconds / 86400} dias atrás"
    else
      "#{time_ago_in_words_long(time)}"
    end
  end

  def format_date(date)
    days_of_week = ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado']
    months_of_year = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']

    day_name = days_of_week[date.wday]
    day = date.day
    month_name = months_of_year[date.month - 1]
    year = date.year

    "#{day_name}, #{day} de #{month_name} de #{year}"
  end

  def time_ago_in_words_long(time)
    distance_of_time_in_words(time, Time.current)
  end
end
