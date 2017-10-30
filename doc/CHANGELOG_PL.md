# LMSAdescomPlugin
Wszelkie wymagające wzmianki zmiany w projekcie będą opisywane w tym pliku.
Projekt wspiera standardy [Semantic Versioning](http://semver.org/) i [Keep a CHANGELOG](http://keepachangelog.com/).

## [1.4.9] - 2017-07-10
###Naprawiono
- listę taryf na formatce dodawania i edycji zobowiązania, bug powstał po zmianach w LMS rev. >= 7ecf65d11025cfbb8be97a0fc0b20054f13ec61d
- wystawianie faktur
- ustawianie ścieżki do biblioteki xajax, bug powstał po zmianach w LMS rev. >= 4c9104ade18c2b01ef38070b7aa5bcbcc997064d
- wystawianie pozycji za abonament na fakturach
- listę billingów VoIP dla klientów bez żadnego konta VoIP
- wybieranie domyślnej grupy numeracyjnej połączeń alarmowych na formatce dodawania konta VoIP
###Dodano
- informację o metodach webserwisów, zobacz README
- informację o wersji centrali
- moduł informacji o centrali
###Zmieniono
- sposób prezentacji informacji o pomyślnym zapisaniu zmian w konfiguracji globalnych ustawień bramy VoIP

## [1.4.8] - 2017-05-16
- Naprawiono wystwianie faktur

## [1.4.7] - 2017-04-28
### Dodano
- instrukcję instalacji modułu Adescom dla panelu abonenckiego LMS

### Naprawiono
- ustawianie ścieżki do biblioteki xajax, bug powstał po zmianach w LMS rev. >= 4c9104ade18c2b01ef38070b7aa5bcbcc997064d
- wystawianie pozycji za abonament na fakturach
- listę billingów VoIP dla klientów bez żadnego konta VoIP

## [1.4.6] - 2017-03-03
### Dodano
- przekazywanie symboli TERYT do CTM
- moduł zarządzanie użytkownikami panelu
- typ taryfy (netto/brutto) jest wyświatlany na formatce edycji zobowiązania VoIP klienta
- usunięte taryfy przypisane do numerów oznaczane są na czerwono
- usunięte taryfy nie są wyświetlane na listach taryf

### Naprawiono
- wybieranie domyślnej grupy numeracyjnej połączeń alarmowych na formatce dodawania konta VoIP

## [1.4.5] - 2017-02-10
### Dodano
- nazwę CTM na liście kont VoIP
- wsparcie dla grup numeracyjnych połączeń alarmowych wybieranych na podstawie geolokalizacji

## [1.4.4] - 2017-02-07
### Dodano
- sprawdzenie kodu pocztowego klienta przez zapisem nowego konta VoIP

### Naprawiono
- ustawianie zobowiązania gdy jako separatora części dziesiętnej użyto ','
- listy grup numeracyjnych

## [1.4.3] - 2017-01-13
### Zmieniono
- automatyczne ładowanie klas w starszych wersjach LMS (zobacz README)
- dokumentację w pliku README.md
- sposób wyświetlania widoku modułu billingu numerów VoIP
- moduł billingu VoIP
- współdzielony kod związany z SOAP, został on wydzielony do zewnętrznej biblioteki
- sposób budowania paczki z pluginem

### Usunięto
- moduł listy traktów
- moduł billingu traktów
- obsługę traktów w module billingu numerów VoIP
- moduł listy rozmów VoIP

## [1.4.2] - 2016-10-27
### Naprawiono
- zapisywanie limitów prepaid i postpaid podczas dodawania konta VoIP, naprawiony bug został wprowadzony w wersji 1.4.0

## [1.4.1] - 2016-10-18
### Zmieniono
- domyślny szablon uprawnień podczas logowania do panelu abonenta (był superuser, jest null)

## [1.4.0] - 2016-10-14
### Zmieniono
- zarządzanie numerem telefonu, modyfikacja wymuszona przez zmiany w LMS, działa od LMS rev. >= 62acfa1
- moduły fakturowania zgodnie ze zmianami w LMS (zobacz problem #559 na koncie LMS na GitHub), działa od LMS rev. >= 33ce74e
- lms-payments (porzucono wersje PERL, wprowadzono wersję PHP)
- lms-payments.php, wprowadzono modyfikacje zgodnie ze zmianami w LMS, działa on LMS rev. >= 486fdb3

## [1.3.3] - 2016-10-14
### Dodano
- sprawdzenie obecnoście opcji allow_self_signed w uiconfig, którą należy określać tylko w lms.ini

### Naprawiono
- pobieranie listy zobowiązań VoIP w przypadku gdy istnieją klienci z zawieszonymi zobowiązaniami

## [1.3.2] - 2016-09-07
### Naprawiono
- ładowanie profili telefonów które powodowało problemy z pozostałym JavaScriptem na formatce dodawania konta VoIP

## [1.3.1] - 2016-09-06
### Dodano
- komentarz w pliku lms.ini, że hasła zawierające znaki specjalne powinny być otoczone apostrofami
- wersję pluginu w opisie pluginu
- opcję kopiowania adresu e-mail z ustawień klienta do ustawień konta VoIP
- opcję pozwalającą na wyłączenie sprawdzania URL

### Naprawiono
- konfigurację Apache dla pewnych statycznych plików pluginu
- funkcję parsującą wyniki zwracane przez metodę getCLIDs z webserwisów frontendowych
- sprawdzanie brakujących domyślnych wartości
- nazwę zobowiązania VoIP na liście zobowiązań klienta w userpanelu w module finanse

## [1.3.0] - 2016-05-25
### Dodano
- sortowanie na liście zobowiązań VoIP
- sprawdzenie krytycznych ustawień w tabeli uiconfig
- opcje pozwalające na ukrycie pól login, status i location na formatkach dodawania i edycji kont VoIP
- ostrzeżenie gdy hasła na CTM i w LMS różnią się

### Naprawiono
- usunięto zdeprecjonowane sprawdzanie statusu aktywności i przeniesienia wpisu na liście kont VoIP
- poprawiono wybieranie linii telefonu z wartości domyślnych oraz po błedach na formatce dodawania kont VoIP

### Zmieniono
- usunięty client jest przywracany podczas dodawania do niego konta VoIP, nie są wyświetlanie komunikaty o błędach

## [1.2.6] - 2016-04-28
### Naprawiono
- wybieranie numeru z puli
- ustawianie wartości domyslnych na formatce dodawania konta VoIP
- dostosowano szybką wyszukiwarkę do zmian jakie miały miejsce w LMS
- status numeru dla telefonów korzystających z protokołu MGCP

### Zmieniono
- obsługę błędów

## [1.2.5] - 2016-04-21
### Dodano
- sprawdzenie czy został przekazany handler połączenia do bazy danych
- logi błędów w przypadku gdy URL do webserwisów są błędne

### Naprawiono
- edycję konta VoIP w przypadku gdy hasło nie jest zmieniane

## [1.2.4] - 2016-03-24
### Dodano
- sprawdzanie poprawności adresów URL WSDL i location

### Zmieniono
- sposób dziedziczenia szablonów - dostosowanie do zmian w LMS

### Naprawiono
- sprawdzanie pewnych ustawień konfiguracyjnych dla faktur w nowych wersjach LMS
- nawiązywanie połączenia do CTM z certyfikatem self-signed

## [1.2.3] - 2016-01-19
### Dodano
- możliwość konfiguracji dodatkowych uprawnień użytkowników do modułów związanych z kontami VoIP
- asynchroniczne ładowanie informacji o stanie salda kont VoIP na liście kont VoIP
- asynchroniczne ładowanie informacji o stanie salda kont VoIP na liście kont VoIP klienta
- szybką wyszukiwarkę klientów na formatce dodawania konta VoIP
- tłumaczenia nagłówków subpaneli na formularzu dodawania konta VoIP
- opcja 'pokaż/schowaj' dla subpaneli na formularzu konta VoIP
- tagi 'label' na subpanelach na formularzy konta VoIP
- rozdzielone subpanele usług VoIP na formularzach dodawania i edycji konta VoIP

### Zmieniono
- usunięto możliwość wyboru klienta na formatce edycji konta VoIP
- wyświetlanie subpaneli na formularzach dodawania i edycji konta VoIP

### Naprawiono
- wyświetlanie odnośnika do billingu na liście kont VoIP
- odnośniki do modułów informacji o kliencie wyświetlane na liście kont VoIP - usunięto zdarzenia onClick które powodowały wysyłanie zbędnych żądań do centrali i wydłużenie czasu oczekiwania na wyniki
- wsparcie dla funkcji getElementsByClassName dla starszych przeglądarek
- wyszukiwanie numeru z puli gdy klient nie jest jeszcze wybrany
- kod javascript na formatce dodawania konta VoIP
- usunięto zbędny kod z nagłówka listy kont VoIP klienta
- zapytanie do drivera postgresql pobierające listę zobowiązań VoIP

## [1.2.2] - 2015-11-02
### Dodano
- dodano listę zobowiązań VoIP

### Zmieniono
- opis pozycji w menu prowadzącej do modułu ustawień bramy VoIP

## [1.2.1] - 2015-09-17
### Zmieniono
- przerobiono mechanizm błędów odczytywanych z centrali Adescom w celu poprawienia ich czytelności

## [1.2.0] - 2015-08-14
### Dodano
- dodano CHANGELOG w języku polskim
- dodano w README informację o obsługiwanych wersjach LMS
- dodano w README informację o sekcji "adescom" w "Konfiguracja" > "Interfejs użytkownika"
- dodano informację o autorze pluginu
- dodano informację o nazwie pluginu

### Zmieniono
- dostosowano szablony do nowego silnika renderowania szablonów w pluginach
- dostosowano znaki końca linii
- porzucono wsparcie dla plików README w formatach HTML i PDF
- zmieniono format pliku CHANGELOG
- usunięto nieaktualne zrzuty ekranu prezentujące plugin
- usunięto z pliku README nieaktualne informacje o łańcuchach znaków z tłumaczeniami, łańcuchy znaków z tłumaczeniami są automatycznie obecnie dołączane w LMS
- usunięto z pliku README nieaktualne informacje o zmiennych "default_" z pliku lms.ini
- ulepszono sposób określania ścieżki do pluginu

### Naprawiono
- naprawiono ostrzeżenia wysyłane przez lms-payments w przypadku napotkania niezdefiniowanych frakcji

## [1.1.12] - 2015-07-30
### Naprawiono
- naprawiono edycję zobowiązań VoIP klientów

## [1.1.11] - 2015-07-21
### Naprawiono
- naprawiono pobieranie informacji o kontach VoIP klientów którzy nie są obecni na centrali VoIP Adescom

## [1.1.10] - 2015-07-13
### Naprawiono
- naprawiono usuwanie klientów którzy nie są obecni na centrali VoIP Adescom

## [1.1.9] - 2015-06-30
### Naprawiono
- naprawiono sprawdzanie wartości domyślnej dla usługi UF2M
- naprawiono problemy z kodowaniem znaków w lms-payments

## [1.1.8] - 2015-06-15
### Dodano
- dodano możliwość pobierania ustawień z uiconfig w lms-payments

### Naprawiono
- zmieniono operatory porównania z "eq" na "==" i z "neq" na "!=" w szablonach Smarty

## [1.1.7] - 2015-05-08
### Dodano
- przeniesiono niektóre ze zmiennych konfiguracyjnych z pliku lms.ini do bazy danych z zachowaniem wstecznej kompatybilności

## [1.1.6] - 2015-04-22
### Dodano
- dodano instrukcję nt. synchronizacji

### Naprawiono
- naprawiono procedurę dodawania kont prepaid dla starszych wersji PHP
- naprawiono ścieżkę do szablonu edycji faktur
- usunięto sprawdzanie uprawnienia do wyboru CTM

## [1.1.5] - 2015-04-10
### Naprawiono
- naprawiono dane zwracane przez handler lmsInit
- zmieniono nazwy niektórych klas w celu uniknięcia konfliktów

## [1.1.4] - 2015-04-02
### Naprawiono
- naprawiono błędy w parserze numerów pobieranych z puli pojawiające się w przypadku korzystania z web serwisów frontendowych

## [1.1.3] - 2015-03-25
### Zmieniono
- zaktualizowano pliki README

## [1.1.2] - 2015-03-19
### Dodano
- dodano plik README

## [1.1.1] - 2015-03-17
### Zmieniono
- usunięto zbędne handlery obsługujące dodawanie i edycję klientów

## [1.1.0] - 2015-03-03
### Zmieniono
- wprowadzono więcej OOP
- dodano więcej dokumentacji
- usunięto zbędny kod

## [1.0.13] - 2015-02-23
### Dodano
- dodano więcej dokumentacji

### Naprawiono
- naprawiono błędy wyświetlane na formatce edycji konta VoIP

## [1.0.12] - 2015-02-17 
### Naprawiono
- zoptymalizowano czas pobierania informacji o kontach VoIP na formatkach z listami kont VoIP
- naprawiono problem z zapisaniem domyślnego absolutnego limitu
- naprawiono problem ze sprawdzaniem czy klient już istnieje na centrali podczas dodawania nowego konta VoIP

## [1.0.11] - 2015-02-11
### Dodano
- dodano poziomy blokowanie na formatce dodawanie konta VoIP

### Naprawiono
- naprawiono problem z doładowaniem konta prepaid wartością w której część dziesiętna oddzielona jet znakiem ","
- naprawiono wyświetlanie informacji o koncie VoIP na formatce doładowania konta prepaid
- naprawiono wyświetlanie poziomów blokowania na formatce edycji konta VoIP

## [1.0.10] - 2015-02-10
### Naprawiono
- naprawiono wysyłanie żądań dodawania klientów
- naprawiono formatki dodawania i edycji zobowiązań kont VoIP

## [1.0.9] - 2015-02-02
### Naprawiono
- naprawiono wyświetlanie błędów na formatce dodawania klienta
- naprawiono filtrowanie billingu
- naprawiono formatki dodawania i edycji faktur

## [1.0.8] - 2015-02-01
### Naprawiono
- naprawiono problemy z wyświetlaniem formatek dodawania i edycji faktur

## [1.0.7] - 2015-01-22
### Naprawiono
- naprawiono wyświetlanie nazwy centrali na szablonie informacji o koncie VoIP

## [1.0.6] - 2015-01-13
### Dodano
- dodano ten changelog

### Naprawiono
- naprawiono zmienianie właścicieli konta VoIP

## [1.0.5] - 2015-01-11
### Naprawiono
- poprawiono wyświetlanie informacji o stanie konta VoIP na formatce informacji o koncie VoIP

## [1.0.4] - 2014-12-07
### Zmieniono
- zmieniono ścieżki do szablonów zgodnie ze zmianami w LMS

## [1.0.3] - 2014-11-14
### Naprawiono
- naprawiono problemy z edycją konta VoIP: ustawiono status na domyślnie włączone, dodano domyślny numer telefonu i login

## [1.0.2] - 2014-11-06
### Zmieniono
- usunięto próby łączenia się z centralą Adescom z modułów gdzie nie jest to wymagane

## [1.0.1] - 2014-11-05
### Naprawiono
- naprawiono zarządzanie zobowiązaniami VoIP
- naprawiono problem z profilami telefonów na formatce dodawania kont VoIP
- naprawiono problem z pulą numerów na formatce dodawania kont VoIP
- naprawiono problem z statusem konta VoIP na formatce informacji o koncie VoIP
- naprawiono blok z informacjami o kontach VoIP na formatce informacji o komputerach
- naprawiono problemy na formatce dodawania nowego klienta

## [1.0.0] - 2014-10-16
### Dodano
- pierwsza wersja pluginu
- dodano zarządzanie kontami VoIP i klientami
- dodano zarządzanie zobowiązaniami VoIP
- dodano pozycje VoIP na fakturach
- dodano raporty billingowe
