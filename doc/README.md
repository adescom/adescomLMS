LMSAdescomPlugin
================

Wymagania
---------

Obowiązkowo, aby uruchomić plugin:

 * LMS GIT od 2ff41783d62566e34ae8f5045d06df87e83fe8a4 (2015-02-11) do c5de997dab26624f27ae8b6df69ec5334a339211 (2015-06-03)
   * obsługiwany przez plugin w wersjach do 1.1.x
 * LMS GIT od e16dc46fddfd62fb613e851302d7533a3e0a7c1b (2015-08-13)
   * obsługiwany przez plugin w wersjach od 1.2.0
 * LMS GIT od 954dfa657beee7c304f7191117b5b8b8cace5d2a (2015-12-22)
   * obsługiwany przez plugin w wersjach od 1.2.6
 * LMS GIT od 62acfa1 (02-09-2016)
   * obsługiwany przez plugin w wersjach od 1.4.0

Opcjonalnie, do uruchomienia lms-payments (wersja perl):

 * SOAP/Lite.pm
 * Date/Simple.pm

Wersja oprogramowania na centrali a plugin
------------------------------------------

Plugin wykorzystuje do komunikacji z centralą udostępnione przez nią webserwisy. 
Ponieważ obecność danej metody webserwisu zależna jest od wersji oprogramowania 
na centrali, część funkcjonalności pluginu może być niedostępna. Poniżej 
wyszczególniono metody webserwisu wykorzystywane przez ten plugin wraz z wersją 
oprogramowania na centrali, od której dana metoda jest obsługiwana.

Webserwisu frontendowe:

4.0.0-R11 getCLID
4.0.0-R11 getTariffs
4.0.0-R11 getPhones
4.0.0-R11 getContexts
4.0.0-R11 deleteCLID
4.0.0-R11 modifyCLID

4.0.1-RC08 addCLIDByExternalID
4.0.1-RC08 addClient
4.0.1-RC08 generateCLIDLicense
4.0.1-RC08 getBillingForClientByExternalID
4.0.1-RC08 getCLIDPostpaidLimits
4.0.1-RC08 getCLIDServices
4.0.1-RC08 setClientLiabilityByExternalID
4.0.1-RC08 setDefaultPostpaidLimits
4.0.1-RC08 getPhone
4.0.1-RC08 userpanelExternalLogin
4.0.1-RC08 userpanelGetExternalUserName
4.0.1-RC08 getClientByExternalID
4.0.1-RC08 getCTMNodeList
4.0.1-RC08 restoreClientByExternalID
4.0.1-RC08 getPrepaidBalance/getCLIDPrepaidAccountState
4.0.1-RC08 modifyCLIDServices/setCLIDServices
4.0.1-RC08 getDefaultPostpaidLimits
4.0.1-RC12 activateCLID
4.0.1-RC15 getFreeNumbersFromPool
4.0.1-RC15 getNumberFromPool/getFirstFreeNumberFromPool
4.0.1-RC15 getPools/getNumberPools
4.0.1-RC16 addPrepaidAmount/addCLIDPrepaidAccountState
4.0.1-R01 getBlockLevels
4.0.1-R01 getCLIDsAccountState
4.0.1-R01 getCLIDsStatus
4.0.1-R01 getTrunkgroupsForClientByExternalID
4.0.1-R01 getVersion

4.1.0-RC08 getCLIDsPostpaidLimits
4.1.0-RC06 getGeoLocationCommunesByCounty
4.1.0-RC06 getGeoLocationCountiesByState
4.1.0-RC06 getGeoLocationStates

4.2.0-RC01 deleteClientLiabilityByExternalID
4.2.0-RC01 getClientLiabilityByExternalID
4.2.0-RC01 setCLIDPostpaidLimits

4.2.1-RC02 getCLIDs

Webserwisy platformowe:

3.6.0-R01 activateCLID
3.6.0-R01 addClient
3.6.0-R01 getNumberFromPool/getFirstFreeNumberFromPool
3.6.0-R01 getCLID
3.6.0-R01 deleteCLID
3.6.0-R01 getContexts
3.6.0-R01 getPhones
3.6.0-R01 getPools/getNumberPools
3.6.0-R01 getPrepaidBalance/getCLIDPrepaidAccountState
3.6.0-R01 getTariffs
3.6.0-R01 addPrepaidAmount/addCLIDPrepaidAccountState
3.6.0-R01 modifyCLID

4.0.0-R13 getGeoLocationCountiesByState
4.0.0-R13 getGeoLocationStates
4.0.0-R14 getBlockLevels

4.2.0-RC02 getGeoLocationCommune

4.2.1-RC12 getBillingForClientByExternalID
4.2.1-RC13 addCLIDByExternalID
4.2.1-RC13 deleteClientLiabilityByExternalID
4.2.1-RC13 getClientByExternalID
4.2.1-RC13 getClientLiabilityByExternalID
4.2.1-RC13 getCLIDs
4.2.1-RC13 setClientLiabilityByExternalID
4.2.1-RC13 getTrunkgroupsForClientByExternalID
4.2.1-RC18 getCLIDPostpaidLimits
4.2.1-RC18 setCLIDPostpaidLimits

4.2.3-RC03 generateCLIDLicense
4.2.3-RC03 getCLIDsAccountState
4.2.3-RC03 getCLIDServices
4.2.3-RC03 getCLIDsPostpaidLimits
4.2.3-RC03 getCLIDsStatus
4.2.3-RC03 getCTMNodeList
4.2.3-RC03 getDefaultPostpaidLimits
4.2.3-RC03 getFreeNumbersFromPool
4.2.3-RC03 getPhone
4.2.3-RC03 setDefaultPostpaidLimits
4.2.3-RC03 modifyCLIDServices/setCLIDServices
4.2.3-RC04 getVersion

4.2.6-RC03 userpanelExternalLogin
4.2.6-RC03 userpanelGetExternalUserName

4.2.7-R04 restoreClientByExternalID

4.2.8-RC23 editPanelUserForClient
4.2.8-RC23 getCredential
4.2.8-RC30 getBillingForClientsByExternalID

4.2.9-RC02 getPanelUsersForClient
4.2.9-RC03 getGeoLocationCommunesByCounty
4.2.9-RC05 addPanelUserForClientByExternalId
4.2.9-RC05 getPanelUser

Instalacja
----------

1. Rozpakować plugin do folderu lms/plugins.
2. Skopiować zawartość lms/plugins/LMSAdescomPlugin/doc/lms.ini do właściwego lms.ini.
3. Zaimportować plik lms/plugins/LMSAdescomPlugin/doc/LMSAdescomPluugin.sql do bazy danych LMS.
4. W lms.ini w sekcji "adescom" podać właściwe URL do webserwisów oraz hasła.
5'. Przeładować autoloder poleceniem 'composer dump-autoload'
6. Odświeżyć stronę LMS.
7'. W razie potrzeby dostosować zmienne w sekcji "adescom" w "Konfiguracja" > "Interfejs użytkownika".

W przypadku starszych wersji pluginu <= 1.2.0:
5". Wyczyścić lms/templates_c oraz lms/cache (pozostawiając tylko pliki .htaccess).
    Dodać w composer.json sekcję autoload taką jak jest w LMS w wersji HEAD.
6". Zalogować się do LMS i w "Konfiguracja" > "Interfejs użytkownika" w sekcji "phpui" dodać opcję "plugins" z zawartością "LMSAdescomPlugin:1" (jeśli opcja plugins istnieje i nie jest pusta to należy dodać zawartość oddzielając ją od poprzedniej znakiem ";").

Instalacja modułu panelu abonenta
---------------------------------

1. Przenieść/skopiować/dowiązać katalog lms/plugins/LMSAdescomPlugin/userpanel/modules/adescom do ścieżki w której przechowywane są moduły panelu abonenta LMS.
2. Ustawić wartość zmiennych userpanel_global_password, userpanel_challenge_salt, userpanel_login_url, userpanel_security_template w pliku lms.ini.
3. Włączyć moduł w manu "Userpanel" > "Konfiguracja".

Funkcjonalność pluginu
----------------------

1. Wyświetlanie listy kont VoIP istniejących na centrali i przypisanych do klienta z LMS, w tym prezentacja:
    * stanu urządzenia VoIP;
    * hasła urządzenia VoIP;
    * adresu IP urządzenia VoIP;
    * taryfy powiązanej z numerem VoIP;
    * stanu konta powiązanego z numerem VoIP;
    * listy usług włączonych dla numeru VoIP.

2. Dodawanie, edycja i usuwanie kont VoIP na centrali, w tym:
    * określanie globalnego miesięcznego limitu;
    * ustawianie podstawowych danych o koncie VoIP;
    * ustawianie taryf;
    * ustawianie poziomów blokowania;
    * edycja usług przypisanych do konta VoIP;
    * zarządzanie limitami przypisanymi do konta VoIP;
    * doładowywanie kont prepaid.

3. Pobieranie danych billingowych, w tym:
    * wyszukiwanie połączeń przychodzących i wychodzących;
    * wyszukiwanie po numerze źródłowym i docelowym;
    * wyszukiwanie w zadanym okresie;
    * prezentacja czasu połączeń, kierunków, naliczonej ceny oraz ceny za minutę;
    * prezentacja podsumowania dla zadanego zapytania.

4. Podstawowe zarządzanie zobowiązaniami po stronie centrali:
    * dodawanie nowego zobowiązania;
    * edycja istniejących zobowiązań;
    * wyświetlanie historii zmian zobowiązania.

5. Pobieranie danych billingowych do faktury tworzonej po stronie LMS:
    * dodawanie pozycji na fakturach tworzonych z interfejsu WWW LMS;
    * dodawanie pozycji na fakturach tworzonych poprzez lms-payments.

6. Logowanie z panelu klienta LMS do panelu abonenta na centrali.

7. Lista zobowiązań VoIP
    * lista pomaga wyszukać klientów posiadających zobowiązania VoIP w CTM
    * lista pomaga wyszukać klientów posiadających taryfy VoIP w LMS
    * Lista pomaga wyszukać rozbieżności pomiędzy taryfami VoIP w LMS a zobowiązaniami VoIP w CTM

Synchronizacja centrali z LMS
-----------------------------

W przypadku występowania rozbieżności pomiedzy listą kont VoIP w LMS i na centrali Adescom należy dokonać synchronizacji.
Poniżej opisano kilka najczęstszych scenariuszy oraz krok po kroku procedurę synchroniacji.

1. Klient istnieje po stronie centrali i LMS (inne konta były już wcześniej łączone):
    1. Wyłączamy plugin w LMS (w konfiguracji interfejsu użytkownika usuwamy opcję plugins lub jeśli mamy tam wpisane więcej pluginów to usuwamy tylko informację o LMSAdescomPlugin).
    2. Dodajemy w LMS konta tak aby w polu login i numer znalazł się clid z centrali.
        Jeśli wiemy jaki był typ rejestracji to w polu "login" wpisujemy odpowiednią kombinację country_code + area_code + short_clid, jeśli nie wiemy to wpisujemy cały clid.
        W polu "hasło" wpisujemy hasło z centrali (jeśli hasło nie może zostać zapisane z powodu niedozwolonych znaków to wpisujemy cokolwiek).
    3. Włączamy plugin w LMS.
    4. Wchodzimy na kartę klienta, a następnie do edycji numeru i zapisujemy numer. 
        Pozwoli to na ewentualną poprawę hasła i loginu po stronie LMS, tak aby były one takie same jak na centrali (uwzględnienie typu rejestracji, niedozwolonych znaków w haśle).

2. Klient nie istnieje po stronie LMS, istnieje na centrali:
    1. Wyłączamy plugin w LMS (w konfiguracji interfejsu użytkownika usuwamy opcję plugins lub jeśli mamy tam wpisane więcej pluginów to usuwamy tylko informację o LMSAdescomPlugin).
    2. Dodajemy klienta w LMS.
    3. Na centrali odnajdujemy klienta i w polu "Dodatkowy ID 1" wpisujemy id z LMS.
    4. Dodajemy konta tak aby w polu login i numer znalazł się clid z centrali (jeśli wiemy jaki był typ rejestracji to w polu login wpisujemy odpowiednią kombinację country_code + area_code + short_clid, jeśli nie wiemy to wpisujemy cały clid), a w polu hasło hasło z centrali (jeśli hasło nie może zostać zapisane z powodu niedozwolonych znaków to wpisujemy cokolwiek).
    5. Włączamy plugin w LMS.
    6. Wchodzimy na kartę klienta a następnie do edycji numeru i zapisujemy numer. 
        Pozwoli to na ewentualną poprawę hasła i loginu po stronie LMS tak aby był taki sam jak na centrali (uwzględnienie typu rejestracji, niedozwolonych znaków w haśle).

3. Klient i konto istnieją po stronie LMS, nie istnieje konto na centrali:
    1. Odnajdujemy klienta, np. wyszukując po nazwisku.
    2. Dodajemy konto na centrali do klienta.
    3. Uzupełniamy "Identyfikator klienta 1" tak aby odpowiadał on ID klienta w LMS.

4. Klient i konto istnieją po stronie LMS, nie istnieje zarówno klient jak i konto na centrali
    1. Dodajemy klienta lub korzystamy ze szybkiego dodawania numerów.
    2. Dodajemy konto VoIP, tak jak opisano w punkcie 3.
