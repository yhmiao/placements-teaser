# Howard Miao Placements-teaser app.

## Features

- Line_items:
  - List line_items with search filter and pagination.
  - Show a line_item record.
  - Editable adjustments and AASM status using AJAX which will also update sub-total.

- Campaigns:
  - List campaigns with search filter and pagination.
  - Show a campaign record with all the associated line_items.
  - Editable AASM status, line_items adjustments and line_item AASM status using AJAX which will also update line_items count and grand total.

- Invoices:
  - List invoices with search filter and pagination.
  - Create new invoices by selecting campaigns that do not belong to other invoices in AASM status: draft, reviewed, and paid.
  - Show an invoice record with all the associated campaigns.
  - Editable AASM status.
  - Add/Remove campaigns which will also update campaigns count and grand total.

- Verisons:
  - List versions with search filter and pagination.
  - Show a version record that logs a change to either a line_item or campaign.

- User Authorization:
  - New sign up.
  - Sign in/Sign out.

## Software Framework

Rails 5.2.4 with Ruby 2.5.7

## Frontend

Jquery and Rails default views.

## Database

sqlite3

## Setup

#### 1. Clone

```
git clone https://github.com/yhmiao/placements-teaser
```

#### 2. Setup Local Environment

Install the following

Necessary:

```
Ruby      2.5.7
Rails     5.2.4
```

#### 3. Setup Rails

Move to project directory:

```
bundle install
rake db:migrate
rake db:seed
rails s
```

Go to `http://localhost:3000` and you should see no error.
