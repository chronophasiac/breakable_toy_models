## Memworks: Boosted E-Learning ##

Memworks is a learning platform that uses [spaced repetition](http://en.wikipedia.org/wiki/Spaced_repetition) to reinforce and improve learning outcomes. Users can select a lesson, and are led through a series of assignments. The assignments consist of curated collections of freely available e-learning resources. 

After the assignments, users are challenged with a series of cards. They are scored on their responses to the challenge, and each card becomes associated with that user. Memworks currently uses the SM2 spaced repetition algorithm to calculate the optimal time for a user to study a card, based on their last time of study and quality of response.

Users can train through a deck of cards consisting of all cards they've completed in a challenge, sorted by most immediately requiring study (as determined by SM2). Users also have a dashboard, where they can see the queue of cards and the next scheduled date of study for each card.

## Getting Started ##

- Clone this repository
- `cd` into the repo
- Execute the following:

        bundle install
        cp config/database.example.yml config/database.yml
        rake db:create db:migrate db:seed

- An admin is provided for you by the seeder:

        admin@memworks.com
        123qweasd
