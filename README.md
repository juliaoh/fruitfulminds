# Fruitful Minds, Inc. - CS 169 Project

This is a class project for CS 169, Software Engineering, at UC Berkeley in Fall 2013.

The goal of the project is to build a user-friendly web application for Fruitful Minds, Inc. which is a non-profit organization whose mission is to combat childhood obesity by delivering a customized nutrition program to communities in need.

* Fruitful Minds Heroku App: http://fruitful-minds.herokuapp.com
* Fruitful Minds current website: http://www.fruitfulminds.org
* SaaS Website: http://beta.saasbook.info

## Developers
Michael Jun, Julia Oh, Alvin Wong, Sam Xu, William Yau, Kevin Yeun

## Getting Started
### GitHub Repo

Note: You have to be added to the list of collaborators of the git repo to push your changes.

1. Clone the repository with the following command at the command prompt
       git clone git@github.com:juliaoh/fruitfulminds.git

2. Change the working directory
       cd fruitfulminds

3. Install the necessary <tt>gems</tt>
       bundle install --without production

4. If built successfully, you can start developing on the application.

### Heroku App

Note: You have to be added to the collaborators of the fruitful-minds heroku app before doing any of the following.

1. Add the heroku git repo to repo cloned from GitHub
      git remote add heroku git@heroku.com:fruitful-minds.git

2. Verify you have access to both git repo and heroku app by running
      git remote -v
    which should return something like this
      heroku  git@heroku.com:fruitfulminds.git (fetch)
      heroku  git@heroku.com:fruitfulminds.git (push)
      origin  git@github.com:juliaoh/fruitfulminds.git (fetch)
      origin  git@github.com:juliaoh/fruitfulminds.git (push)

3. If you get a "permission denied error" when you push to heroku, do the following first, then try to push again.
      heroku keys:add

### Clarifications

There are a few misleading terms.

1. Presurvey refers to the survey taken by students before the curriculum, or pre-curriculum survey.

2. Courses are uniquely identified by a combination of School, Semester, and Curriculum (e.g. Ascend Elementary, Fall 2013, 5th Grade Curriculum)

3. Curriculum is also survey_template (5th grade curriculum is 5th grade survey_template)

4. Curriculum has many sections, which have many questions

5. Historical Data reporting ...

Credit: Many parts of the code base has been contributed by a previous CS169 Group 25 from Fall 2012.
