# Use the official Ruby image
FROM ruby:3.1.4

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the application code
COPY . .

# Expose the port that Rails runs on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
