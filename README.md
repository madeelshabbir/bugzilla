# BUGZILLA

Buzilla is a Bug Tracking System. It has three user roles (Developer, Manager and QA) and each play its own role with different access in it and these are mentioned below:

**Manager:**

* can create multiple Projects.

* can add/remove Developer/QA from his created Projects.

* can edit and delete his created project

* can see all the Projects and Bugs.

* can't report or delete any Bug.

* can't edit status of any Bug.


**Developer:**

* can only see those Projects on which he is working.

* can only see those Bugs which are relavent to his Projects.

* can edit the status of Bug by assigning it to himself when he assigned any Bug to himself no one other than him can change the bug status.

* can't create/edit/delete any Project.

* can't add/remove any user from Projects.

* can't create/delete any Bugs.


**QA:**

* can only see all Projects.

* can report Bugs in any Project.

* can see Bugs from Project.

* can delete Bug from any Project.

* can't change status of any Bug.

* can't add/remove any user from Projects.

**How to setup the app**

* Step 1: Clone the repository using 'git clone https://github.com/adeeldevsinc/Bugzilla.git'.

* Step 2: Install Ruby 2.6, Rails 5.2 and Postgres version 0.18 to <2.0.

* Step 3: Run bundle in project's root directory.

* Step 4: Create application.yml in config directory and write environment variables in it.

* Step 5: Setup database and perform migrations.

* Step 6: Run 'rails db:seed'. (Optional)

* Step 7: Run project using 'rails s' or 'rails server'.

**Environment Variables**

* For Postgres Credentials:
  postgres_user_name - representing Postgres Username
  postgres_password - representing Postgres Password

* For Cloudinary Credentials:
  cloudinary_cloud_name - representing Cloudinary Cloud Name
  cloudinary_api_key: - representing Cloudinary API Key
  cloudinary_api_secret - representing Cloudinary API Secret

* For SMTP Settings:
  smtp_domain - representing SMTP Domain
  smtp_user_name - representing SMTP Username
  smtp_password - representing SMTP Password
