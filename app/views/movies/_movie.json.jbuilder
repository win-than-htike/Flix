json.extract! movie, :id, :title, :description, :total_gross, :released_on, :created_at, :updated_at
json.url movie_url(movie, format: :json)