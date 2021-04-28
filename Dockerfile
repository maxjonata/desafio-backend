FROM ubuntu:latest

COPY . .

RUN apt -y update
RUN apt -y install ruby-full 

RUN gem install rspec