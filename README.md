# robot-framework
<b>This is a test automation framework which uses the following concepts/tools to automate tests on the Binary site:</b>
- Robot Framework
- Selenium2Library
- Travis CI for continuous integration
- Headless Browser Testing

<b>Currently automated tests are already developed for following pages in binary.com:</b>
- Login Page
- Personal Details Page
- Login History Page
- Change Password Page
- Cashier Password Page
- API Token Page
- Authorized Applications Page
- Login History Page
- Trading Page : Buy and Manual Sell Contract
- Japan Trading Times
- Footer: Social Network Mailer Link
- Create Virtual Account (currently run in QA10)
- Statement Page
- Portfolio Page


<b>Running the tests:</b>

Project can be cloned/downloaded from github url https://github.com/binary-com/robot-framework.

Each test will be automatically triggered by Travis CI upon each code push to the repository and build status can be viewed at the below url: https://travis-ci.org/binary-com/robot-framework/builds/.

<b>Browsers:</b>

Currently tests are running on Chrome Headless Browser using xvfb (X Virtual Framebuffer) provided by Travis CI.

<b>Integration with binary-static</b>


Tests are running against binary staging site and whenever any tests fail on binary-static-ci it will send an email notification to concerned persons.Front-end team will make the fix the issues in staging itself before any release to production.


