# LMSAdescomPlugin
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/) and [Keep a CHANGELOG](http://keepachangelog.com/).

## [1.4.9] - 2017-07-10
###Fixed
- tariffs list at customer assignment add and edit form, bug after changes in LMS rev. >= 7ecf65d11025cfbb8be97a0fc0b20054f13ec61d
- Invocies fix
- setting path to xajax library, bug after changes in LMS rev. >= 4c9104ade18c2b01ef38070b7aa5bcbcc997064d
- adding subscribe items to invoice
- VoIP billing list for customers without any VoIP account
- selecting default emergency context at VoIP account add form
###Added
- webservices method info, see README
- ctm version info
- ctm info module
###Changed
- presentation of succesfully saves global settings changes

## [1.4.8] - 2017-04-28
### Fixed
- Invocies fix

## [1.4.7] - 2017-04-28
### Added
- instructions of installation for Adescom userpanel module

### Fixed
- setting path to xajax library, bug after changes in LMS rev. >= 4c9104ade18c2b01ef38070b7aa5bcbcc997064d
- adding subscribe items to invoice
- VoIP billing list for customers without any VoIP account

## [1.4.6] - 2017-03-03
### Added
- passing VoIP account TERYT symbols to CTM
- panel user management module
- tariff type (brutto/netto) is displayed at customer VoIP assignment edit form
- deleted tariffs assigned to number are displayed in red color
- deleted tariffs are not longer displayed at tariffs list

### Fixed
- selecting default emergency context at VoIP account add form

## [1.4.5] - 2017-02-10
### Added
- CTM node name at VoIP account lists
- support for emergency context from geo location

## [1.4.4] - 2017-02-07
### Added
- check for customer zip code before new VoIP account save

### Fixed
- liability set action when price has ',' as decimal separator
- context group lists

## [1.4.3] - 2017-01-13
### Changed
- autoloading of plugins classes for older LMS versions (see README)
- documentation in README.md file
- VoIP numbers billings view
- VoIP billings module
- common SOAP code, it has been moved to external library
- plugin deploy method

### Removed
- trunk list module
- trunk billing module
- trunk support from VoIP billing module
- VoIP calls module

## [1.4.2] - 2016-10-27
### Fixed
- saving prepaid and postpaid limits while adding new VoIP account, fixed bug has been introduced in version 1.4.0

## [1.4.1] - 2016-10-18
### Changed
- default security template for userpanel external login (was superuser, now null)

## [1.4.0] - 2016-10-14
### Changed
- phone number processing, modification according to changes in LMS, works from LMS rev. >= 62acfa1
- invoice modules according to changes in LMS (see issue #559 at LMS GitHub), works from LMS rev. >= 33ce74e
- lms-payments (PERL version abondonned, PHP version introduced) 
- lms-payments.php modification according to changes in LMS, works from LMS rev. >= 486fdb3

## [1.3.3] - 2016-10-14
### Added
- check for allow_self_signed option in uiconfig wich should be defined only in lms.ini file

### Fixed
- fetching of VoIP assigments list when customers with suspended assignments exist

## [1.3.2] - 2016-09-07
### Fixed
- phone profiles loading which has been causing problems with JavaScripts at new VoIP account add form

## [1.3.1] - 2016-09-06
### Added
- comment in lms.ini file that password containing special chars should be wrapped with apostrophes
- plugin version in plugin description
- option to copy customer e-mail from customer settings to VoIP account settings
- option to turn off URL checks

### Fixed
- Apache config for some plugin assets
- getCLIDs method results parser for frontend webservices
- checking of missing default values
- VoIP assignment name at customer assignments list in userpanel finances module

## [1.3.0] - 2016-05-25
### Added
- sorting at voip assignments list
- check for critical settings in uiconfig table
- options to hide login, status and location fields at VoIP add and edit forms
- warning when VoIP password at CTM and LMS differs

### Fixed
- removes deprecated checking for active and ported entries at VoIP account list
- selecting of a phone line from defaults and after error at VoIP account add form

### Changed
- restores deleted clients while adding new VoIP to them instead of displaying errors messages

## [1.2.6] - 2016-04-28
### Fixed
- selecting number from a pool
- setting defaults at VoIP account add form
- adjustments to quick search changes in LMS
- clid status for MGCP protocol phones

### Changed
- error handling

## [1.2.5] - 2016-04-21
### Added
- check for DB connection handler
- error logs when webservice URLs are invalid

### Fixed
- VoIP account update when password has not changed

## [1.2.4] - 2016-03-24
### Added
- WSDL and location URL checks

### Changed
- way of template inheritance - adjustment to LMS

### Fixed
- checking of some invoice configuration variables for new LMS
- connecting to CTM with self-signed certificate

## [1.2.3] - 2016-01-19
### Added
- possibility to configure additional user access rights to VoIP modules
- asynchronous loading of VoIP accounts state at VoIP accounts list
- asynchronous loading of VoIP accounts state at customer VoIP accounts list
- quick search for customer at VoIP add form
- polish I18N for VoIP account add form subpanel
- 'show/hide' function for VoIP account form subpanels
- 'label' HTML tags at VoIP account form subpanels
- splited VoIP service's subpanels at VoIP add and edit forms

### Changed
- removed customer select list from VoIP edit form
- displaying of VoIP account form subpanels

### Fixed
- displaying of billing link at voip accounts list template
- links to customer info modules from VoIP accounts list - onClick events have been removed to avoid useless request and decrease rendering time
- getElementsByClassName function support for older browsers
- pool number search when customer is not selected yet
- javascript code at VoIP account add form
- removed useless code from client's VoIP accounts list header
- VoIP assignments search query for postgresql db driver

## [1.2.2] - 2015-11-02
### Added
- added VoIP assignments list

### Changed
- changed VoIP gateway menu entry description

## [1.2.1] - 2015-09-17
### Changed
- changed adescom errors handlers to produce more readable errors

## [1.2.0] - 2015-08-14
### Added
- added CHANGELOG in polish language
- added supported LMS versions informations in README file
- added information about "adescom" section in "User Interface Configuration" > "User Interface"
- added plugin author informations
- added plugin name informations

### Changed
- adjusted templates to new plugin templates management engine
- adjusted EOLs
- droped support for HTML and PDF versions of README
- changed CHANGELOG format
- removed deprecated plugins screen shots
- removed deprecated informations about translation strings from README file, translation strings are now automatically merged in LMS
- removed deprecated informations about "default_" variables in lms.ini file
- improved plugin directory path determination

### Fixed
- fixed warnings for non defined fractions in lms-payments

## [1.1.12] - 2015-07-30
### Fixed
- fixed customer VoIP assignments edit methods

## [1.1.11] - 2015-07-21
### Fixed
- fixed customer's voip accounts get method for customers than are not present at Adescom VoIP central

## [1.1.10] - 2015-07-13
### Fixed
- fixed customer delete action for customers that are not present at Adescom VoIP central

## [1.1.9] - 2015-06-30
### Fixed
- fixed default value for UF2M checking
- fixed some encoding problems in lms-payments script

## [1.1.8] - 2015-06-15
### Added
- added lms-payments ability to use uiconfig adescom section variables

### Fixed
- changed "eq" to "==" and "neq" to "!=" Smarty comparison operators

## [1.1.7] - 2015-05-08
### Added
- some config variables from lms.ini have been moved to database with backward compatibility

## [1.1.6] - 2015-04-22
### Added
- added synchronization howto

### Fixed
- fixed prepaid account add procedure for older versions of PHP
- fixed path to invoice edit template
- removed right to select ctm local check

## [1.1.5] - 2015-04-10
### Fixed
- added return statement in lmsInit handler
- changed some class names to avoid conflicts

## [1.1.4] - 2015-04-02
### Fixed
- fixed free numbers from pool request parser for frontend webservice

## [1.1.3] - 2015-03-25
### Changed
- updated README files

## [1.1.2] - 2015-03-19
### Added
- README file

## [1.1.1] - 2015-03-17
### Changed
- removed customer add and customer edit handlers

## [1.1.0] - 2015-03-03
### Changed
- added more OOP
- added more documentation
- removes deprecated code

## [1.0.13] - 2015-02-23
### Added
- added some documentation

### Fixed
- fixed error displaying at VoIP account edit form

## [1.0.12] - 2015-02-17 
### Fixed
- optimised execution time of VoIP accounts information lists
- fixed problem with saving default absolute limit
- fixed problem with checking if client already exists at CTM while adding new VoIP account

## [1.0.11] - 2015-02-11
### Added
- added block levels to VoIP add form

### Fixed
- fixed prepaid charge/recharge problem with ',' separated decimal values
- fixed displaying of VoIP account info at prepaid recharge form
- fixed displaying of block levels at VoIP edit form

## [1.0.10] - 2015-02-10
### Fixed
- fixed add clients webservice request
- fixed VoIP assignments add and edit forms

## [1.0.9] - 2015-02-02
### Fixed
- fixed displaying errors at customer add form
- fixed billing filtering
- fixed add and edit invoice forms

## [1.0.8] - 2015-02-01
### Fixed
- fixed problems with displaying invoice add form

## [1.0.7] - 2015-01-22
### Fixed
- fixed CTM name at VoIP informations print page

## [1.0.6] - 2015-01-13
### Added
- added this changelog

### Fixed
- fixed VoIP account owner switching

## [1.0.5] - 2015-01-11
### Fixed
- fixed VoIP account status at VoIP info form

## [1.0.4] - 2014-12-07
### Changed
- changed templates path according to changes in LMS

## [1.0.3] - 2014-11-14
### Fixed
- fixed VoIP edit problems: sets account access to true by default, provides default phone and login

## [1.0.2] - 2014-11-06
### Changed
- removed Adescom connection where it is not required

## [1.0.1] - 2014-11-05
### Fixed
- fixed VoIP assignment management
- fixed phone profile problem at VoIP add form
- fixed pool problem at VoIP add form
- fixed VoIP status at VoIP info form
- fixed VoIP box at node info form
- fixed problems at customer add form

## [1.0.0] - 2014-10-16
### Added
- first version of a plugin
- VoIP and customer management
- VoIP assignments
- VoIP liabilities at invoice items list
- billing reports
