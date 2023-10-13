# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# # Install development tools and necessary dependencies
RUN apt-get update && apt-get install -y nodejs

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock from your Rails app
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
