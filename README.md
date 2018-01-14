![The Metric Logo](/img/logo.png?raw=true)

# The Metric

A scalable web application to house diverse content by a wide range of editors, contributors, and administrators. We aim to give a voice to passionate college students and raising political literacy and engagement. This project has scaled to 20+ contributors and thousands of weekly readers.

Website: [https://themetric.org](https://themetric.org)

![The Metric](/img/screenshot.png?raw=true)

### Stack
* Ruby 2.3
  * Rails 5.1
  * PostgreSQL: database
  * Devise: helper gem for user model and security
  * Sendgrid: sending emails to users
  * AWS S3: image storage
  * Paperclip gem: image uploading
  * Trix: in-browser text editor
* JavaScript
* jQuery
* Bootstrap 4 alpha
* [Strapper](https://github.com/ccabo1/strapper)
* SCSS
* HTML/ERB

### Security and admins
We needed an application which was intuitive yet secure: editors and content creators around the world must be able to create accounts and get seamlessly to doing their jobs. That being said, some verification structure must be in place to ensure that not just anyone could create an account.

Further, there must be some level of hierarchy among admins because not all contributors should have the same privileges. Specifically, only specific people should be able to publish, feature, un-publish, and delete articles, as well as manage the privileges of other admins.

I thus delineated between being an `admin` and being a `superAdmin`, where only `superAdmins` have the ability to upgrade `admins` to `superAdmins`. This effectively distributes privileges between different roles without complicating the application to the point that it's not intuitive.

`superAdmins` are also the ones in control of who can register as new users. This is handled through the `referrals` controller: `superAdmins` can add and delete `emails` from the list of referred `admins`. Only those with referred emails can create accounts.

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

### Recommending articles and organizing the homepage
We want as much user engagement on the platform as possible. Presenting information in a stimulating and targeted manner is an effective means of accomplishing this.

All articles keep track of the number of `views` on the article over two-week periods, after which point the `views` count is reset to zero. This ensures that the "most read" articles refer to the most popular articles over the past two weeks.

These "most read" articles are displayed on the sidebar on the front page. Apart from the featured article, the remaining articles are conglomerated loosely by chronological order.

When a user is viewing an article, we also aim to provide meaningful recommendations for next reads in two ways:
1. Having next and previous articles based on chronology at the bottom of the article page.
2. Having randomly chosen recent articles from either the same region or same topic as the current article in a right sidebar.

### Creating a meaningful user experience
Our content brings a fresh perspective, thus we want our site to convey and extend that purpose. I accomplished this by incorporating vibrant blues and purples into a holistically bright yet bold layout.

It's a fully responsive, mobile-first site which puts content first.

### Feature tracking

__General__
- [x] Name transfer (to whatever we decide)
- [x] Configure AWS to a new bucket
- [x] `Friendly_id`
  - [x] ...for admins
  - [x] ...for articles
- [x] Better error throwing on admin security
- [x] Published only on front page
- [x] Show that an article is unpublished if this is an admin on index page
- [x] Email list in footer / popup
- [x] Tags only when article open
- [x] Grey column widths on mid-sized screens
- [x] Clean up JS code for fixed stuff on article show page?
- [x] Complete meta tags
- [x] Rename Disqus thread to "The Metric" or "Metric"
- [x] Test share buttons when published
- [x] SendGrid configuration for contact page
- [x] Create GoDaddy Email
- [x] Link with domain name
- [x] SSL certificate
- [x] Favicon
- [x] Link to google form
- [x] 2 articles on index
- [ ] Improve search

__Views__
- [x] Pretty forms
  -  [x] Adjust spacing of active label (x-axis)
  - [x] Pretty article form
  - [x] Get the special label to work (even on page transfers?)
    - [x] Test this further
- [x] Article show pages
  - [x] Author information on article show page
  - [x] Region information on article show page
- [x] Front page?
  - [x] Better categorization and section titles on front page
- [x] Clean up admin show pages
  - [x] Maybe export articles to their own cards?
- [x] Admin index pages
- [x] Fix popup
  - [x] Also fix popup javascript stuff
- [x] Add region in more places?
- [x] One sentence pitch in footer
- [x] Content for about page
- [x] Highlight color
- [x] Sidebar on article show
- [x] Fixed recommendations

__Admin configuration__
- [x] Admin controller
  - [x] Name
  - [x] Bio
  - [x] Social media links
  - [x] Profile picture
- [x] User roles? Who can edit what?
- [x] Restrictions on who can make accounts / who can be admins?
- [x] Update edit form, make sure it works with names, bios
- [x] Admin can edit admin show page if on their own
- [x] Link to admin show page if logged in
- [x] Admin information page
- [x] Add location to admin

__Article configuration__
- [x] Add locations to posts / region
  - [x] Add select field in form for articles
- [x] Better categorization for posts
- [x] Ability to have `published` and `unpublished` posts
- [x] Handle article not found on show page
- [x] Links to share on social media
  - [x] Desktop
  - [x] Mobile / small screen
- [x] Search for articles by name
- [x] Add topics to articles (economics and finance, security, politics, science and innovation, culture, opinion)
  - [x] Topics in navbar dropdown
  - [x] Display opinion on article index
- [x] Better article recommendations
- [x] Captions on images

__Details__
- [x] Play around with title and subtitle overlay on article preview
- [x] Articles from same region on right side of article show page on large screens
- [x] Google analytics
- [x] Link to destroy emails as fitting
- [x] Fixed nav only on scroll up, hide on scroll down?
- [x] Responsive column counts for articles
- [x] More columns on articles index page
- [x] Colors on about gradient
- [x] Try to make markdown less necessary (replace with editor?)
- [x] Sample bio stuff
- [x] Recommendations for photo
- [x] Meet the team, show profiles on about page
- [x] Most viewed articles on right?
- [x] Links to social media in navbar
- [x] Admin can delete their own article if it is not published
- [x] Collapse navbar at wider size
- [x] Add URL's to social media for links

__Down the line__
- [ ] Paginate or scroll to load more articles
- [ ] Allow super admin to lock / delete other admin accounts
- [ ] SendGrid for Devise?
