# robot-framework
<b>This is a test automation framework which uses the following concepts/tools to automate tests on the Binary site:</b>
- Robot Framework
- Selenium2Library
- Travis CI for continuous integration
- Headless Browser Testing

<b>Currently automated tests are already developed for the following pages in binary.com:</b>
- Login Page
- <b>Profile</b>: Personal Details, Financial Assessment
- <b>Security & Limits</b>: Account Password, Cashier Password, Limits, Login History, API Token Page, Authorized Applications 
- <b>Trading</b>: Buy Contract, Manual Sell Contract
- Japan Trading Times
- Footer: Social Network Mailer Link
- Create Virtual Account (currently run in QA10)
- Upgrade Real CR Account (currently run in QA10)
- Statement Page
- Portfolio Page
- Profit Table Page

<b>Running the tests:</b>

Project can be cloned/downloaded from github url https://github.com/binary-com/robot-framework.

Each test will be automatically triggered by Travis CI upon each code push to the repository and build status can be viewed at the below url: https://travis-ci.org/binary-com/robot-framework/builds/.

<b>Browsers:</b>

Currently tests are running on Chrome Headless Browser using xvfb (X Virtual Framebuffer) provided by Travis CI.

<b>Integration with binary-static</b>

Tests are running against binary staging site and whenever any test failed, it will send an email notification to concerned persons. Issues in staging will be fixed before any release to production.


