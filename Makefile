-include $(CURDIR)/.env

_:
	make init

init:
	docker-compose up -d
	yarn
	make import
	@make message

message:
	@echo ""
	@echo "--------------------------------------------------------------------------------------------"
	@echo ""
	@echo "        _______ _______ . _______      _______ _______ _______  ______ _______"
	@echo " |      |______    |    ' |______      |______    |    |_____| |_____/    |"
	@echo " |_____ |______    |      ______|      ______|    |    |     | |    \_    |"
	@echo ""
	@echo " _     _ _______  ______ ______       _  _  _  _____   ______ _     _ _____ __   _  ______"
	@echo " |_____| |_____| |_____/ |     \      |  |  | |     | |_____/ |____/    |   | \  | |  ____"
	@echo " |     | |     | |    \_ |_____/      |__|__| |_____| |    \_ |    \_ __|__ |  \_| |_____|"
	@echo ""
	@echo " _     _ __   _ _______ _____             __   __  _____  _     _      ______  _____ _______"
	@echo " |     | | \  |    |      |   |             \_/   |     | |     |      |     \   |   |______"
	@echo " |_____| |  \_|    |    __|__ |_____         |    |_____| |_____|      |_____/ __|__ |______"
	@echo ""
	@echo "--------------------------------------------------------------------------------------------"
	@echo ""

clean:
	docker-compose down
	docker-compose up -d
	make import

# DUMP
import:
	bash tools/shell-scripts/db-import.sh

import-from-production:
	bash tools/shell-scripts/db-import.sh $(PRODUCTION_ECCUBE_HOME) $(LOCAL_ECCUBE_HOME)

import-from-staging:
	bash tools/shell-scripts/db-import.sh $(STAGING_ECCUBE_HOME) $(LOCAL_ECCUBE_HOME)

export:
	bash tools/shell-scripts/db-export.sh

export-to-production:
	bash tools/shell-scripts/db-export.sh $(PRODUCTION_ECCUBE_HOME) $(LOCAL_ECCUBE_HOME)

export-to-staging:
	bash tools/shell-scripts/db-export.sh $(STAGING_ECCUBE_HOME) $(LOCAL_ECCUBE_HOME)
