![The Metric logo](https://s3-us-west-1.amazonaws.com/ccabo/metric-logo.png)

A scalable web application to house diverse content by a wide range of editors, contributors, and administrators. We aim to give a voice to passionate college students and to raise political literacy and engagement. This project has scaled to 30+ contributors and thousands of weekly readers.

![Website screenshot](https://s3-us-west-1.amazonaws.com/ccabo/metric-screenshot.png)

---

### Local development

To run the application locally, first clone the repository. From the repository root directory, run:

```bash
bundle install
```

This installs of the ruby gems (or packages) specified in the `gemfile.rb` file. Once this is done, you are ready to begin developing:

```bash
rails s
```

---

### Deploying to production

If you made a change to the assets (any of the `scss` files), we have to make a production-ready build of them before re-deploying to Heroku:

```bash
bundle exec rake assets:precompile
```

The application is hosted on Heroku. Heroku effectively has its own git server for managing content. As soon as a new commit is made on the master branch of the Heroku git server, it is built and that is the new production app. To push to Heroku, run:

```bash
git push heroku master
```

---

### Technical Stack

**Backend:**

- Ruby on Rails
- Devise: helper gem for user model and security
- Sendgrid: sending emails to users
- AWS S3: image storage
- Paperclip gem: image uploading
- Trix: in-browser text editor
- PostgreSQL: database

**Frontend:**

- JavaScript
- jQuery
- Bootstrap 4
- [Strapper](https://github.com/ccabo1/strapper)
- SCSS
- HTML/ERB

---

### Security and admins

We needed an application which was intuitive yet secure: editors and content creators around the world must be able to create accounts in a simple yet secure way. That being said, some verification structure must be in place to ensure that not just anyone could create an account and write articles.

Further, there must be some level of hierarchy among admins because not all contributors should have the same privileges. Specifically, only specific people should be able to publish, feature, un-publish, and delete articles, as well as manage the privileges of other admins.

We thus delineate between an `admin` and a `superAdmin`, where only a `superAdmin` has the ability to upgrade an `admin` to a `superAdmin`. This distributes privileges between different roles without complicating the application to the point that it's not intuitive or too heavy-handed.

`superAdmins` are also the ones in control of who can register as new users. This is handled through the `referrals` controller: `superAdmins` can add and delete `emails` from the list of referred `admins`. Only those with referred emails can create accounts.

_Down the line, we should send emails to referred users with tokens for registering such that we can confirm they are in control of their email addresses._

---

### Articles and organization

We needed a way to house articles of diverse content relating to diverse topics. As such, having a flexible online editor and the ability to categorize and prioritize articles is of the utmost importance.

We first split articles by `region` (North America, Latin America, Europe, Middle East & North Africa, Africa, and Asia & Oceania) and `topic` (Economics & Finance, Security, Politics, Science & Innovation, Culture, and Opinion).

While editing articles, authors can also add a comma-separated `tags-list` to add more targeted filtering to their piece. It follows that articles can be filtered by either `tag`, `region`, or `topic`.

A `superAdmin` also has the option to `feature` a post, meaning that it will show up as the main article on the homepage of the site. In featuring one article, if some other article were featured at that time, it would be un-featured.

The body of articles is written using the [Trix editor](https://trix-editor.org/) with additional support for parsing images with captions of the form:

```
[http://link.com/to-image.jpg,caption line 1,caption line 2]
```

This gives writers an intuitive interface while also providing all of the functionality needed to produce powerful content.

---

### Recommending articles and organizing the homepage

We want as much user engagement on the platform as possible. Presenting information in a stimulating and targeted manner is an effective means of accomplishing this.

All articles keep track of the number of `views` on the article over two-week periods, after which point the `views` count is reset to zero. This ensures that the "most read" articles refer to the most popular articles over the past two weeks.

These "most read" articles are displayed on the sidebar on the front page. Apart from the featured article, the remaining articles are conglomerated loosely by chronological order.

When a user is viewing an article, we also aim to provide meaningful recommendations for next reads in two ways:

1. Having next and previous articles based on chronology at the bottom of the article page.
2. Having randomly chosen recent articles from either the same region or same topic as the current article in a right sidebar.

---

### Creating a meaningful user experience

Our content brings a fresh perspective, thus we want our site to convey and extend that purpose. I accomplished this by incorporating vibrant blues and purples into a holistically bright yet bold layout.

It's a fully responsive, mobile-first site which puts content first.

---

### Feature tracking

Features are now tracked through Trello, with communication handled via Slack. If you want to be added to either of these platforms, please reach out to Cameron Cabo.
