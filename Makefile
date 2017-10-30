CP=/bin/cp
RM=/bin/rm
TAR=/bin/tar
GREP=/bin/grep
MKDIR=/bin/mkdir
COMPOSER=/usr/local/bin/composer

RELEASE_DIR=./release
VENDOR_DIR=$(RELEASE_DIR)/vendor

PLUGIN_VERSION=`$(GREP) -o 'version: [0-9].[0-9].[0-9]' LMSAdescomPlugin.php | $(GREP) -o '[0-9].[0-9].[0-9]'`

install: clean composer build pack
	
test: clean composer-dev build-dev pack
	
clean:
	$(RM) -f LMSAdescomPlugin_*.tar.gz
	$(RM) -rf $(RELEASE_DIR)/*
	
composer-dev: clean
	$(COMPOSER) update --optimize-autoloader
	
composer: clean
	$(COMPOSER) update --optimize-autoloader --no-dev
	
build:
	$(MKDIR) -p $(VENDOR_DIR)
	$(CP) ./LMSAdescomPlugin.php $(RELEASE_DIR)
	$(CP) -r ./bin $(RELEASE_DIR)
	$(CP) -r ./doc $(RELEASE_DIR)
	$(CP) -r ./handlers $(RELEASE_DIR)
	$(CP) -r ./img $(RELEASE_DIR)
	$(CP) -r ./lib $(RELEASE_DIR)
	$(CP) -r ./modules $(RELEASE_DIR)
	$(CP) -r ./templates $(RELEASE_DIR)
	$(CP) -r ./userpanel $(RELEASE_DIR)
	$(CP) -r ./vendor/adescom $(VENDOR_DIR)/adescom
	$(CP) -r ./vendor/composer $(VENDOR_DIR)/composer
	$(RM) -f $(VENDOR_DIR)/composer/installed.json
	$(RM) -rf $(VENDOR_DIR)/adescom/soap/.svn
	$(RM) -rf $(VENDOR_DIR)/adescom/soap/tests/
	
build-dev: build
	$(CP) -r ./vendor/* $(VENDOR_DIR)
	
pack:
	$(TAR) czvf LMSAdescomPlugin_$(PLUGIN_VERSION).tar.gz -C $(RELEASE_DIR) . --owner=0 --group=0